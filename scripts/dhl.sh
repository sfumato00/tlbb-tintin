#!/bin/bash

main_file="dhl_main.tin"

sessions=(
    "dhla" # 西夏中心
    "dhlb" # 小山坡
    "dhlc" # 西夏大道-松鹤楼
    "dhld" # 开封东
    "dhle" # 洛阳中心
    # "dhlh" # 大理戏院
)

for session in "${sessions[@]}"; do
    screen -X -S $session "quit"
    screen -dmS $session bash -c "tt++ $main_file; exec bash"
    screen -X -S "$session" -p 0 -X stuff "conn $session\n"
    echo "Screen session '$session' created."
done
