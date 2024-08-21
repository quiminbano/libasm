#!/bin/bash

function run_test_function()
{
	if [ ! -d "outputs" ]; then
		mkdir -p outputs
	fi
	if c++ -Wall -Wextra -Werror -std=c++11 src/test_"$1".cpp -L.. -lasm -o test_"$1" &> /dev/null; then
		for i in $(seq 1 "$2")
			./test_"$1" $i
			usleep 50000
	else
		echo "[ERROR COMPILING THE TEST]"
		usleep 50000
	fi
}

function run_mandatory()
{
	individualTests=("strlen" "strcpy" "strcmp" "write" "read" "strdup")
	numberOftestsPerTest=(5 5 1 1 1 1)
	index=0
	for instruction in "${individualTests[@]}"; do
		run_test_function "$instruction" "$numberOftestsPerTest[$index]"
		index=$((test + 1))
	done
}

function run_bonus()
{
	individualTests=("atoi_base" "list_size" "list_push_front" "list_sort" \
	"list_delete_if")
	numberOftestsPerTest=(1 1 1 1 1)
	index=0
	for instruction in "${individualTests[@]}"; do
		run_test_function "$instruction" "$numberOftestsPerTest[$index]"
		index=$((test + 1))
	done
}

function clean_library()
{
	if make -C ..; then
		echo "libasmTester: Invalid compilation of the Makefile"
		exit 1
	fi
}

function compile_library()
{
	if make fclean -C ..; then
		echo "libasmTester: the tester couldn't run the rule fclean from your Makefile"
		exit 1
	fi
}

function detect_test()
{
	globalInstructions=("all" "mandatory" "bonus")
	individualTests=("strlen" "strcpy" "strcmp" "write" "read" "strdup" \
	"atoi_base" "list_size" "list_push_front" "list_sort" "list_delete_if")
	numberOftestsPerTest=(5 5 1 1 1 1 1 1 1 1 1)
	isInGlobal=false
	testName=""
	index=0
	for instruction in "${globalInstructions[@]}"; do
		if [ "$1" == "$instruction" ]; then
			isInGlobal=true
			break
		fi
	done
	if [ "$isInGlobal" == true ] && [ "$1" == "all" ]; then
		run_mandatory
		run_bonus
	elif [ "$isInGlobal" == true ] && [ "$1" == "mandatory" ]; then
		run_mandatory
	elif [ "$isInGlobal" == true ] && [ "$1" == "bonus" ]; then
		run_bonus
	else
		for instruction in "${individualTests[@]}"; do
			if [ "$instruction" == $1 ]; then
				run_test_function "$instruction" "$numberOftestsPerTest[$index]"
				break
			fi
			index=$((index + 1))
		done
	fi
}

string1=""
isFound=false
if [ $# -eq 0 ]; then
	string1="all"
elif [ $# -eq 1 ]; then
	string1=$1
else
	echo "libasmTester: Too many parameters"
	exit 1
fi
string1=$(echo "$string1" | tr '[:upper:]' '[:lower:]')
possibleArguments=("all" "mandatory" "bonus" "strlen" "strcpy" "strcmp" \
"write" "read" "strdup" "atoi_base" "list_size" "list_push_front" \
"list_sort" "list_delete_if")

for element in "${possibleArguments[@]}"; do
	if [ "$string1" == "$element" ]; then
		isFound=true
		break
	fi
done
if [ "$isFound" == false ]; then
	echo "libasmTester: invalid argument."
	exit 1
fi
compile_library
detect_test "$string1"
clean_library
