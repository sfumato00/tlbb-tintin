#!/bin/bash

main_file="fight_main.tin"

sessions=(
    "doge"
)

for session in "${sessions[@]}"; do
    screen -X -S $session "quit"
    screen -dmS $session bash -c "tt++ $main_file; exec bash"
    screen -X -S "$session" -p 0 -X stuff "conn $session\n"
    echo "Screen session '$session' created."
done
