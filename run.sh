#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to display usage instructions
usage() {
    echo "Usage: $0 <session_name>"
    exit 1
}

# Check if the session name is provided
if [ -z "$2" ]; then
    echo "Error: Session name is required."
    usage
fi

MAIN_FILE="$1"
# Extract session name from the first argument
SESSION_NAME="$2"
# screen -X -S $SESSION_NAME "quit"
# Create the profile file path
tin_profile="./profiles/profile_${SESSION_NAME}.tin"

echo "debug: $tin_profile"

# Check if the profile file exists
if [ ! -f "$tin_profile" ]; then
    echo "Error: Profile file '$tin_profile' does not exist."
    exit 1
fi

# Start a new screen session and run tintin++ with the profile file
screen -dmS "$SESSION_NAME" bash -c "tt++ $MAIN_FILE && exec bash"

# Send 'conn <session_name>' and 'Enter' to the screen session
screen -X -S "$SESSION_NAME" -p 0 -X stuff "conn ${SESSION_NAME}$(printf '\r')"

# Switch into the screen session
screen -r "$SESSION_NAME"