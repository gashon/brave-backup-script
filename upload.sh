#!/bin/bash

export GIT_TRACE_PACKET=1
export GIT_TRACE=1
export GIT_CURL_VERBOSE=1

# Constants
tar_file='brave-browser.tar.gz'
split_prefix='brave-part-'
dir_to_archive="/Users/$USER/Library/Application Support/BraveSoftware/Brave-Browser"
split_size='50m'
repo_url="https://github.com/gashon/brave-backup"
temp_git_folder="tmp_git"

# Shallow clone into a temp directory
rm -rf $temp_git_folder  # remove old temp folder if it exists
git clone --depth 1 $repo_url $temp_git_folder

# Move to the shallow cloned directory
cd $temp_git_folder

# Create new archive
tar cvzf $tar_file "$dir_to_archive"
if [ $? -ne 0 ]; then
    echo "Failed to create archive."
    exit 1
fi

# Split archive
split -b $split_size -d $tar_file $split_prefix
rm -f $tar_file

# Copy, add, commit, and push each split file
for split_file in ${split_prefix}*; do
    git add $(basename $split_file)
    git commit -m "cron: adding $(basename $split_file) on $(date)"
    git push origin main
done

# Cleanup
cd ..
rm -rf $temp_git_folder