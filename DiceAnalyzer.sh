#!/bin/bash

# Variable and if statement to find if there is an /mnt/ directory
path="/mnt"

if ls "$path" >/dev/null 2>&1; then
    path="/mnt"
else
    path=""
fi

source "$path"/c/Revature/DiceGame-mknode/FunctionLibrary.sh

diceStats=""$path"/c/Revature/DiceGame-mknode/DiceRollStats.txt"

# Initialize arrays; users and freq are associative arrays
diceRollsArr=()
uniqueUsers=()
rollCountByUser=()
declare -A users
declare -A roll_frequ

# Make array with the values of each dice roll
while read -r line; do
    # Parameter expansion/variable substitution - substring removal
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

# Make associative array with each unique user and how many times they've rolled
while read -r line; do
    user="${line%%:*}"

    if [[ ${#user} -gt 1 && ! " ${users[@]} " =~ " ${user} "  ]]; then  
        (( users["$user"]++ ))
    fi
done < "$diceStats"

# Make array with only the amount of times each user has rolled to average them
for key in "${!users[@]}"; do
    rollCountByUser+=("${users[$key]}")
done

# Printing statistics to analysis text file
echo -n "DICE GAME STATS: " >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt && date >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo -e "\nTotal Amount of Rolls: \n${#diceRollsArr[*]}" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo -e "\nUsers and Roll Count:" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
for user in "${!users[@]}"; do 
    echo "$user: ${users[$user]}" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
done
echo "Total Number of Users: ${#uniqueUsers[*]}"  >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
echo -n "Average Amount of Rolls: " >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt && avg "${rollCountByUser[@]}" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo -e "\nFrequency of Each Number:" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
roll_freq roll_frequ ""$path"/c/Revature/DiceGame-mknode/DiceRollStats.txt" ""$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt"

echo -e "\nSum of All Rolls:" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
sum "${diceRollsArr[@]}" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo -e "\nAverage of Rolls:" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
avg "${diceRollsArr[@]}" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo -e "\nMode of Rolls:" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
mode_num "${diceRollsArr[@]}" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo "------------------------------------------------" >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo >> "$path"/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

#roll_count "${diceRollsArr[@]}"
#echo "${uniqueUsers[*]}"
#echo "Array Length: ${#uniqueUsers[*]}"