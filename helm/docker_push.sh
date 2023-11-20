#!/bin/bash

# Directory containing the saved tar files
tar_files_dir="image_tar_files"

# Local repository prefix
local_repo_prefix="local-repo/"

# Check if the tar files directory exists
if [ ! -d "$tar_files_dir" ]; then
  echo "Error: Tar files directory '$tar_files_dir' not found."
  exit 1
fi

# Iterate through each tar file in the directory
for tar_file in "$tar_files_dir"/*.tar; do
  # Extract the image name from the tar file
  # Load the Docker image from the tar file
  image_name=$(docker load -i "$tar_file" | awk -F' ' '{print $3}')

  # Rename the loaded image with the local repository prefix
  docker tag "$image_name" "$local_repo_prefix$image_name"

  # Push the image to the local repository
#    docker push "$local_repo_prefix$image_name"

  echo "Pushed image '$local_repo_prefix$image_name' to the local repository."
done
