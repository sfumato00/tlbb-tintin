#!/bin/bash

for file in profile_*.tin; do
    if [ -f "$file" ]; then
        temp=${file#profile_}
        session_name=${temp%.tin}

        screen -X -S $session_name "quit"
        screen -dmS "$session_name" bash -c "tt++ main.tin"
        screen -X -S "$session_name" -p 0 -X stuff "conn $session_name\n"
        echo "Screen session '$session_name' created."
    fi
done

sleep 3

for file in profile_*.tin; do
    if [ -f "$file" ]; then
        temp=${file#profile_}
        session_name=${temp%.tin}

        screen -X -S "$session_name" -p 0 -X stuff "y\n"
    fi
done