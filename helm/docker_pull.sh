#!/bin/bash

# Input file containing Docker image names (one per line)
input_file="image_names.txt"

# Output directory for saving tar files
output_dir="image_tar_files"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "Error: Input file '$input_file' not found."
  exit 1
fi

# Iterate through each line in the input file and pull/save the Docker images
while IFS= read -r image; do
  # Pull the Docker image
  docker pull "$image"

  # Save the Docker image as a tar file
  image_name=$(echo "$image" | tr ':' '_' | tr '//' @) # Replace ':' with '_' in image name
  tar_file="$output_dir/$image_name.tar"
  docker save -o "$tar_file" "$image"
done < "$input_file"
