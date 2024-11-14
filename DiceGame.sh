#!/usr/bin/bash

# Dice Roller used to gather statistics of which number is rolled

#Variables to set values that RANDOM can be below
min=1
max=6

res="Y"

# Inputs for player name and if they would like to roll the dice
echo -n "Please Enter First Name: "
read -r name

while [[ "$res" == "Y" || "$res" == "y" ]]; do
 
	echo -n "Would you like to roll the dice? (INPUT Y TO ROLL): "
	read -r res

	if [[ "$res" = "Y" || "$res" == "y" ]]; then 
		echo "Rolling Dice..."
		diceRoll=$((RANDOM % ($max-$min+1)+$min))
		echo "$diceRoll"
#		echo "$res"
		echo ""$name": $diceRoll" >> ./DiceRollStats.txt
	else
		echo "Invalid selection. Kill..."
		echo "$res" >> ./DiceRollStats.txt
	fi
done
