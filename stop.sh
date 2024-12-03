#!/bin/bash

for file in profile_*.tin; do
    if [ -f "$file" ]; then
        temp=${file#profile_}
        session_name=${temp%.tin}

        screen -X -S $session_name quit > /dev/null 2>&1
    fi
done

