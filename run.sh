#!/bin/bash

for file in profile_*.tin; do
    if [ -f "$file" ]; then
        temp=${file#profile_}
        session_name=${temp%.tin}

        screen -X -S $session_name "#zap" > /dev/null 2>&1
        screen -X -S $session_name quit > /dev/null 2>&1
        screen -dmS $session_name bash -c "tt++ $file; exec bash"

        if screen -list | grep -q $session_name; then
            echo "Screen session '$session_name' started successfully"
        else
            echo "Failed to start screen session"
            exit 1
        fi
    fi
done

