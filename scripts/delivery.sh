#!/bin/bash

DIRECTORY="./profiles"

if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory '$DIRECTORY' does not exist."
    exit 1
fi

session_names=()

for file in "$DIRECTORY"/delivery_*.tin; do
    if [ -f "$file" ]; then

        filename=$(basename "$file")             # Get the filename without the path
        extracted_part="${filename#delivery_}"   # Remove the "profile_" prefix
        session_name="${extracted_part%.tin}" # Remove the ".tin" suffix

        screen -X -S $session_name "quit"
        screen -dmS $session_name bash -c "tt++ delivery_main.tin; exec bash"
        screen -X -S "$session_name" -p 0 -X stuff "conn $session_name\n"
        echo "Screen session '$session_name' created."

        session_names+=("$session_name")
    fi
done