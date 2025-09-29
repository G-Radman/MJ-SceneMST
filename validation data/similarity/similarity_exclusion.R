#!/usr/bin/env Rscript

# ============================================================
# Script: similarity_exclusion.R
# Purpose: Generate exclusion list of categories from 
#          similarity pilot data (simpilot_master.csv).
# Author: Gustaf Rådman
# Repo: MJ-SceneMST
# ============================================================

library(tidyverse)

# --- Paths (relative to repo root) ---
master_file <- here::here("validation data", "similarity", "simpilot_master.csv")
output_file_remove <- here::here("validation data", "similarity", "excluded_categories.txt")
output_file_diff   <- here::here("validation data", "similarity", "difference_data.csv")
output_file_ratings<- here::here("validation data", "similarity", "similarity_ratings.csv")

# --- Load master file ---
df <- read_csv(master_file, show_col_types = FALSE)

# Ensure similarity is a factor with proper ordering
df <- df %>%
  mutate(sim_category = factor(sim_category, levels = c("low", "moderate", "high")),
         sim_rating = as.numeric(sim_rating))

# --- Mean ratings per similarity level per category ---
df_mean_ratings <- df %>%
  group_by(category, sim_category) %>%
  summarise(mean_rating = mean(sim_rating, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(names_from = sim_category, values_from = mean_rating)

# --- Summary with mean + sd for difference calculation ---
df_summary <- df %>%
  group_by(category, sim_category) %>%
  summarise(mean_value = mean(sim_rating, na.rm = TRUE),
            sd_value   = sd(sim_rating, na.rm = TRUE),
            .groups = "drop") %>%
  mutate(sim_category = factor(sim_category, levels = c("low", "moderate", "high")))

df_wide <- df_summary %>%
  pivot_wider(names_from = sim_category, values_from = c(mean_value, sd_value)) %>%
  mutate(
    high_low_diff      = mean_value_high - mean_value_low,
    high_moderate_diff = mean_value_high - mean_value_moderate,
    moderate_low_diff  = mean_value_moderate - mean_value_low
  )

# --- Identify correct vs incorrect categories ---
df_correct <- df_wide %>%
  filter(high_low_diff > 0, high_moderate_diff > 0, moderate_low_diff > 0)

df_incorrect <- df_wide %>%
  filter(!(high_low_diff > 0 & high_moderate_diff > 0 & moderate_low_diff > 0))

# --- Lowest average diff among correct categories ---
category_lowest_avg_diff <- df_correct %>%
  mutate(average_diff = (high_moderate_diff + moderate_low_diff) / 2) %>%
  slice_min(average_diff, n = 2) %>%
  pull(category)

# --- Build exclusion list ---
categories_to_remove <- unique(c(df_incorrect$category, category_lowest_avg_diff))

# --- Save exclusion list ---
writeLines(categories_to_remove, con = output_file_remove)
message("Exclusion list saved to: ", output_file_remove)

# --- Save difference data for kept categories ---
categories_to_keep <- setdiff(df_wide$category, categories_to_remove)

df_diff_to_save <- df_wide %>%
  filter(category %in% categories_to_keep) %>%
  select(category, high_moderate_diff, moderate_low_diff)

write_csv(df_diff_to_save, output_file_diff)
message("Difference data saved to: ", output_file_diff)

# --- Save similarity ratings (mean values) ---
write_csv(df_mean_ratings, output_file_ratings)
message("Similarity ratings saved to: ", output_file_ratings)

# --- Print results ---
message("Categories to remove:")
print(categories_to_remove)
