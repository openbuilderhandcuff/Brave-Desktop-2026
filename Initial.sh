#!/bin/sh

TARGET_DIR="${1:-.}"

echo "File Statistics"
echo "================"
echo "Directory: $TARGET_DIR"
echo

files=$(find "$TARGET_DIR" -type f 2>/dev/null)
file_count=$(printf "%s\n" "$files" | sed '/^$/d' | wc -l)
directory_count=$(find "$TARGET_DIR" -type d 2>/dev/null | wc -l)

total_size=0

for file in $files; do
    size=$(wc -c < "$file" 2>/dev/null)
    total_size=$((total_size + size))
done

echo "Files: $file_count"
echo "Directories: $directory_count"
echo "Total Size: $total_size bytes"

echo
echo "File List"
echo "---------"

find "$TARGET_DIR" -type f -maxdepth 2 2>/dev/null | while read -r file; do
    size=$(wc -c < "$file" 2>/dev/null)
    echo "$file | $size bytes"
done

echo
echo "Analysis completed."