#!/bin/bash

# Function to kill all screen sessions
kill_all_sessions() {
    echo "Killing all screen sessions..."
    sessions=$(screen -ls | grep -P '\t' | awk '{print $1}')
    
    if [ -z "$sessions" ]; then
        echo "No active screen sessions found."
        exit 0
    fi
    
    while IFS= read -r session; do
        # Extract the session alias part after the dot
        session_alias=$(echo "$session" | awk -F'.' '{print $2}')
        echo "Killing session: $session_alias ($session)"
        screen -S "$session" -X quit
    done <<< "$sessions"
    
    echo "All sessions killed."
}

# Function to kill sessions with a specific prefix
kill_sessions_with_prefix() {
    local prefix=$1
    echo "Looking for screen sessions with alias prefix: $prefix"
    
    sessions=$(screen -ls | grep -P '\t' | awk '{print $1}' | grep "\\.$prefix")
    
    if [ -z "$sessions" ]; then
        echo "No active screen sessions found with prefix '$prefix'."
        exit 0
    fi
    
    while IFS= read -r session; do
        # Extract the session alias part after the dot
        session_alias=$(echo "$session" | awk -F'.' '{print $2}')
        echo "Killing session: $session_alias ($session)"
        screen -S "$session" -X quit
    done <<< "$sessions"
    
    echo "All matching sessions killed."
}

# Check arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 <session_prefix> to kill sessions with prefix"
    echo "       $0 -a to kill all sessions"
    exit 1
fi

# Process based on arguments
if [ "$1" = "-a" ]; then
    kill_all_sessions
else
    kill_sessions_with_prefix "$1"
fi