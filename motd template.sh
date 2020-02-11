#!/bin/bash

#tparm will set the amount of lines of your temp info, change it in order to show properly all your CPUs / cores.
tparm=2

#Lines to be displayed inside the hash symbol box
arrlines=("example line 1" "example line 2")

centertext()
{
	echo "$(($(($cols/2))-$((${1}/2))))"
}
draw()
{
	clear
	cols=$(tput cols)
	lines=$(tput lines)
	verticallength=$((${#arrlines[@]}*2+2+$lines/4))
	#Upper horizontal line
	for var in $(seq 0 1 $cols)
	do
		tput cup $(($lines/4)) $var; echo "#"
	done
	#Left vertical line
	for var in $(seq $(($lines/4)) 1 $verticallength)
	do 
		tput cup $var 0; echo "#"
	done
	#Horizontal lower line
    	for var in $(seq 0 1 $cols)
	do
		tput cup $verticallength $var; echo "#"
	done
	#Right vertical line
	for var in $(seq $(($lines/4)) 1 $verticallength)
	do 
		tput cup $var $cols; echo "#"
	done
	tput sgr 0
}

colors()
{
	#Upper horizontal line
	for var in $(seq 0 1 $cols)
	do
		tput cup $(($lines/4)) $var; echo -e "\e[34m#"
	done
	#Left vertical line
	for var in $(seq $(($lines/4)) 1 $verticallength)
	do 
		tput cup $var 0; echo -e "\e[34m#"
	done
	#Horizontal lower line
    	for var in $(seq 0 1 $cols)
	do
		tput cup $verticallength $var; echo -e "\e[34m#"
	done
	#Right vertical line
	for var in $(seq $(($lines/4)) 1 $verticallength)
	do 
		tput cup $var $cols; echo -e "\e[34m#"
	done
}

drawarr()
{
	linecont=0
	for var in ${!arrlines[@]}
	do
		linecont=$(($linecont+2))
		tput cup $(($lines/4+$linecont)) $(centertext ${#arrlines[$var]}); echo "${arrlines[$var]}"
	done
}

extrainfo()
{
	tput sgr 0 

	tput cup $(($verticallength+2)) 0; echo -e "Temperatures (\e[33m$(date +%H:%M:%S)\e[39m):"

	tput cup $(($verticallength+4)) 0; echo -e "\e[31m$(sensors | tail -n$(($(sensors | wc -l)-2)) | head -n$tparm | cut -d"(" -f1)"

	tput cup $(($lines-4)) 0; echo -e "\e[33m$(date +%a" "%b" "%d" - "%Y)\n\e[39mWelcome \e[32m$(whoami)"

	tput sgr 0
}

draw
drawarr
colors
extrainfo
tput cup $lines 0
















 
