#!/bin/bash
set -e

# Constants
tar_file='brave-browser.tar.gz'
split_prefix='brave-part-'
dir_to_archive="/Users/<user>/Library/Application Support/BraveSoftware/Brave-Browser" # Note the quotes here
split_size='50m'  # split the tar file into 50MB chunks to stay under GitHub's 100MB limit

# Create new archive
tar cvzf $tar_file "$dir_to_archive"
if [ $? -ne 0 ]; then
    echo "Failed to create archive."
    exit 1
fi

# Split archive
split -b $split_size -d $tar_file $split_prefix
rm -f $tar_file

git add -A
git commit -m "cron: $(date)"
git push -f

for old_file in ${split_prefix}*; do
    if [ -f "$old_file" ]; then
        echo ""removing $old_file""
        rm -f $old_file
    fi
done

