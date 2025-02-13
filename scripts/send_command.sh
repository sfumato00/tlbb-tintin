#!/bin/bash

main_file="./dev_main/sybil_main.tin"

sessions=(
    "fable"
    "pineapple" "dynamites" "butterfly" "amplitude" "charcoal" "stargazer" "volcanism" "dangerous" "waterfall"
)
for session in "${sessions[@]}"; do
    screen -X -S "$session" -p 0 -X stuff "#CLASS sybil_gift READ {./dev_pkg/pkg_sybil_gift.tin};\n"
    # screen -X -S "$session" -p 0 -X stuff "quit;\n"
done