# ==========================================
# Script: image_metrics.R
# Purpose: Compute image-level CR/d' metrics and averages from mst_master.csv
# Repository folder: MJ-SceneMST
# Author: Gustaf Rådman
# ==========================================

# --- Load libraries ---
library(tidyverse)
library(here)

# --- Define paths relative to GitHub repository ---
mst_master_path <- here("validation data", "mst", "mst_master.csv")
output_csv_path <- here("validation data", "mst", "mst_metrics.csv")

# --- Load the master file ---
mst_data <- read_csv(mst_master_path, show_col_types = FALSE)

# --- Ensure proper factor levels ---
mst_data <- mst_data %>%
  mutate(
    sim_cat = factor(sim_cat, levels = c("high", "moderate", "low")),
    scene_cat = factor(scene_cat)
  )

# --- Step 1: Compute image-level raw counts per mem_role ---
image_probs <- mst_data %>%
  group_by(scene_cat, sim_cat, mem_role) %>%
  summarise(
    n_old_responses = sum(mem_resp == 1, na.rm = TRUE),
    n_total_presentations = n(),
    .groups = "drop"
  ) %>%
  mutate(
    prob_old = n_old_responses / n_total_presentations,
    prob_old_corrected = case_when(
      prob_old == 0 ~ 0.5 / n_total_presentations,
      prob_old == 1 ~ (n_total_presentations - 0.5) / n_total_presentations,
      TRUE ~ prob_old
    )
  )

# --- Step 2: Pivot to get Target, Lure, and Foil on same row per image ---
image_metrics <- image_probs %>%
  pivot_wider(
    id_cols = c(scene_cat, sim_cat),
    names_from = mem_role,
    values_from = c(prob_old, prob_old_corrected),
    names_glue = "{mem_role}_{.value}"
  )

# --- Step 3: Compute average similarity, realism, and confidence per image ---
image_avg_metrics <- mst_data %>%
  group_by(scene_cat, sim_cat) %>%
  summarise(
    avg_similarity = mean(mean_sim_rating, na.rm = TRUE),
    avg_realism = mean(realism, na.rm = TRUE),
    avg_confidence = mean(mem_conf, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  drop_na(avg_similarity, avg_realism)

# --- Step 4: Combine CR/d' metrics with averages ---
image_metrics_final <- image_metrics %>%
  left_join(image_avg_metrics, by = c("scene_cat", "sim_cat")) %>%
  mutate(
    CR_Lure = Target_prob_old - Lure_prob_old,
    CR_Foil = Target_prob_old - Foil_prob_old,
    d_prime_Lure = qnorm(Target_prob_old_corrected) - qnorm(Lure_prob_old_corrected),
    d_prime_Foil = qnorm(Target_prob_old_corrected) - qnorm(Foil_prob_old_corrected)
  )

# --- Step 5: Save final image metrics CSV ---
write_csv(image_metrics_final, output_csv_path)

message("Image metrics CSV successfully written to: ", output_csv_path)
