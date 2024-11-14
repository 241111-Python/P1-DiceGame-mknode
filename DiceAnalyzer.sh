#!/bin/bash
source ./FunctionLibrary.sh

diceStats="DiceRollStats.txt"

# Initialize arrays; users and freq are associative arrays
diceRollsArr=()
uniqueUsers=()
declare -A users
declare -A freq

# Make array with the values of each dice roll
while read -r line; do
    roll="${line#*: }"

    if [[ "$roll" =~ ^[1-6]$ ]]; then
        diceRollsArr+=("$roll")
    fi
done < "$diceStats"

# Make array with each user; entering unique users only once
while read -r line; do
    user="${line%%:*}"
    if [[ ${#user} -gt 1 && ! " ${uniqueUsers[@]} " =~ " ${user} " ]]; then
        uniqueUsers+=("$user")
    fi
done < "$diceStats"

while read -r line; do
    user="${line%%:*}"

    if [[ ${#user} -gt 1 && ! " ${users[@]} " =~ " ${user} "  ]]; then 
        (( users["$user"]++ ))
    fi
done < "$diceStats"


echo "${diceRollsArr[@]}"
echo "Rolls Array Length: ${#diceRollsArr[*]}"

echo "${uniqueUsers[*]}"
echo "Array Length: ${#uniqueUsers[*]}"

for user in "${!users[@]}"; do 
    echo "$user: ${users[$user]}" 
done

sum "${diceRollsArr[@]}"
avg "${diceRollsArr[@]}"
mode_num "${diceRollsArr[@]}"

#roll_count "${diceRollsArr[@]}"
