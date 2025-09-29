"""
set_download_example.py

Example script for downloading image sets directly from the MJ-SceneMST GitHub repository.
Users can specify which image resolution and sets to download, and the script will place
the files into local folders organized by set.

Rules for downloading:
- Target / Foil: only the file ending in "_1" is downloaded.
- Lure: both files ending in "_1" and "_2" are downloaded.
- Downloaded images are renamed to include their assigned role (mem_role).
"""

import os
import pandas as pd
import requests

# -------------------------------------------------------------------------
# USER SETTINGS – edit these values before running
# -------------------------------------------------------------------------
image_resolution = "1024x1024"          # Options: "612x612", "800x800", "1024x1024"
sets_to_grab = [1, 2, 3, 4, 5]          # Example: [1, 2, 3, 4, 5]
output_base = r"C:\Users\gu7563ni\Local\test"  # Local path to store downloaded images

# GitHub repo info
github_user = "G-Radman"
repo_name = "MJ-SceneMST"
branch_name = "main"

# Paths inside the repo
images_folder_in_repo = f"images/{image_resolution}"
csv_path_in_repo = "image%20sets/set_information.csv"  # space replaced with %20
# -------------------------------------------------------------------------


def load_set_info():
    """
    Load the set_information.csv file from the GitHub repo.
    Returns a pandas DataFrame with the full set information.
    """
    csv_url = f"https://raw.githubusercontent.com/{github_user}/{repo_name}/{branch_name}/{csv_path_in_repo}"
    return pd.read_csv(csv_url)


def download_file(url: str, save_path: str):
    """
    Download a single file from a URL and save locally.
    """
    response = requests.get(url)
    if response.status_code == 200:
        with open(save_path, "wb") as f:
            f.write(response.content)
        print(f"Downloaded {save_path}")
    else:
        print(f"⚠️ Failed to download {url} (status {response.status_code})")


def download_images_for_sets(df: pd.DataFrame, sets: list, resolution: str, output_dir: str):
    """
    Download all images for the requested sets and resolution.
    Creates one folder per set in the output directory.
    """
    for set_number in sets:
        df_subset = df[df["Set"] == set_number]
        set_folder = os.path.join(output_dir, f"Set_{set_number}")
        os.makedirs(set_folder, exist_ok=True)

        for _, row in df_subset.iterrows():
            mem_role = row["mem_role"]
            scene_cat = row["scene_cat"]
            sim_cat = row["sim_cat"]

            # Determine suffixes: Lure needs _1 and _2, others only _1
            suffixes = ["_1"]
            if mem_role.lower() == "lure":
                suffixes.append("_2")

            for suffix in suffixes:
                filename = f"{scene_cat}_{sim_cat}{suffix}.png"  # adjust extension if needed
                file_url = (
                    f"https://raw.githubusercontent.com/"
                    f"{github_user}/{repo_name}/{branch_name}/{images_folder_in_repo}/{filename}"
                )

                dst_filename = f"{mem_role}_{filename}"
                dst_path = os.path.join(set_folder, dst_filename)
                download_file(file_url, dst_path)


def main():
    """
    Main workflow:
    1. Load set info CSV from GitHub
    2. Filter to requested sets
    3. Download images into organized folders
    """
    print("Loading set information from GitHub...")
    df = load_set_info()
    df = df[df["Set"].isin(sets_to_grab)]

    print(f"Downloading sets {sets_to_grab} at resolution {image_resolution}...")
    download_images_for_sets(df, sets_to_grab, image_resolution, output_base)

    print("✅ Download complete.")


if __name__ == "__main__":
    main()
