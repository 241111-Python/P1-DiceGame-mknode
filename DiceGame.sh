#!/usr/bin/bash

# Dice Roller used to gather statistics of which number is rolled and who rolled

#Variables to set values that RANDOM can be below
min=1
max=6

res="Y"

# Inputs for player name and if they would like to roll the dice
echo -n "Please Enter First Name: "
read -r name
while [[ "${#name}" -le 1 ]]; do
	echo -n "Name Must Be Longer Than One Character; Please Try Again: "
	read -r name
done

#Loop for user to roll dice; provides a choice if they would like to keep rolling or not
while [[ "$res" == "Y" || "$res" == "y" ]]; do
 
	echo -n "Would you like to roll the dice? (INPUT Y TO ROLL/ANY OTHER CHARACTER TO QUIT): "
	read -r res

	if [[ "$res" = "Y" || "$res" == "y" ]]; then 
		echo "Rolling Dice..."
		diceRoll=$((RANDOM % ($max-$min+1)+$min))
		echo "$diceRoll"
#		echo "$res"
		echo ""$name": $diceRoll" >> ./DiceRollStats.txt
	else
		echo "THANKS FOR PLAYING!"
		echo "$res" >> ./DiceRollStats.txt
	fi
done
