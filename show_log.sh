#!/bin/bash
# Directory containing the log files
LOG_DIR="./log"
# Pattern for matching files
PATTERN="fight_*.log"

# Loop through each file that matches the pattern
for file in "$LOG_DIR"/$PATTERN; do
    # Check if the file exists (in case there are no matches)
    if [[ -f "$file" ]]; then

        session=$(basename "$file")
        session=${session#fight_}  # Remove the 'fight_' prefix.
        session=${session%.log}

        last_line=$(tail -n 1 "$file")

        echo "[$session] $last_line"
    fi
done