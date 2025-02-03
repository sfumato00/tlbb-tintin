#!/bin/bash
screen -ls | awk '/\t/ {print $1}' | xargs -I {} screen -S {} -X quit