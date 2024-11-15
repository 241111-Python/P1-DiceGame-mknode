#!/bin/bash
source /mnt/c/Revature/DiceGame-mknode/FunctionLibrary.sh

diceStats="/mnt/c/Revature/DiceGame-mknode/DiceRollStats.txt"

# Initialize arrays; users and freq are associative arrays
diceRollsArr=()
uniqueUsers=()
declare -A users
declare -A roll_frequ

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



# Make associative array with each unique user and how many times they've rolled
while read -r line; do
    user="${line%%:*}"

    if [[ ${#user} -gt 1 && ! " ${users[@]} " =~ " ${user} "  ]]; then  
        (( users["$user"]++ ))
    fi
done < "$diceStats"

echo -n "DICE GAME STATS: " >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt && date >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo -e "\nTotal Amount of Rolls: \n${#diceRollsArr[*]}" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo -e "\nUsers and Roll Count:" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
for user in "${!users[@]}"; do 
    echo "$user: ${users[$user]}" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
done

echo -e "\nFrequency of Each Number:" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
roll_freq roll_frequ "/mnt/c/Revature/DiceGame-mknode/DiceRollStats.txt" "/mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt"

echo -e "\nSum of All Rolls:" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
sum "${diceRollsArr[@]}" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo -e "\nAverage of Rolls:" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
avg "${diceRollsArr[@]}" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo -e "\nMode of Rolls:" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt
mode_num "${diceRollsArr[@]}" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo "------------------------------------------------" >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

echo >> /mnt/c/Revature/DiceGame-mknode/DiceStatAnalysis.txt

#roll_count "${diceRollsArr[@]}"
#echo "${uniqueUsers[*]}"
#echo "Array Length: ${#uniqueUsers[*]}"