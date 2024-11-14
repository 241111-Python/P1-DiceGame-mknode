#!/bin/bash


function roll_count() {
    local array=("$@")
    local count=0

    for i in "${array[@]}"; do
        count=$((count+1))
    done
    
    echo "$count"
}

function sum(){
    local array=("$@")
    local sum=0

    for i in "${array[@]}"; do
    sum=$((sum+i))
    done

    echo "$sum"
}

function avg() {
    local array=("$@")
    local sum=$(sum "${array[@]}")
    local total_count=${#array[@]}
    local avg=0

    if [[ total_count -gt 0 ]]; then
        avg=$((sum/total_count))
    fi

    echo "$avg"
}

function mode_num() {
    local array=("$@")
    # Associative array - has key-value pairs
    local -A freq
    local max_count=0
    local mode

    for i in "${array[@]}"; do
        ((freq["$i"]++))
    done

    for i in "${!freq[@]}"; do
        if [[ "${freq["$i"]}" -gt "$max_count" ]]; then
            max_count=${freq["$i"]}
            mode="$i"
        fi
    done

    echo "$mode"
}

#user_freq

#exitCount() {
#    local array=("$@")

#    echo ""
#}

"$@"