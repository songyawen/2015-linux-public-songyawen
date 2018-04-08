#!/bin/bash

#read tsv file into array

function deal_with_tsv_file {
	file_path=$1
	#str_arr=$(cat -A $file_path | grep -oP '[\w\s]+\^I')
	i=0
	flag_col_name=1
	#cat -A $file_path | while read line; do	
		#str_arr=$(echo $line | grep -oP '[\w\s]+')
	while read -r line; do
		if [[ $flag_col_name == 1 ]];then 
			flag_col_name=0
		else 
		str_arr=(${line[@]// /*})
		gr_arr[$i]=${str_arr[0]}
		co_arr[$i]=${str_arr[1]}
		rank_arr[$i]=${str_arr[2]}
		jer_arr[$i]=${str_arr[3]}
		pos_arr[$i]=${str_arr[4]}
		age_arr[$i]=${str_arr[5]}
		sel_arr[$i]=${str_arr[6]}
		club_arr[$i]=${str_arr[7]}
		pl_arr[$i]=${str_arr[8]}
		special=${str_arr[9]}
		if [[ $special != $special ]];then
			special=${str_arr[10]}
		fi
		cap_arr[$i]=$special
		i=$(($i+1))
		#else
		#	echo $i
		#	echo "$line"
		#	echo ${#str_arr[@]}
		#fi
	fi
	done < $file_path 
	player_count=$i
	echo $i
}

function get_age {
	tw_down=0
	bet_tw_th=0
	th_up=0
	for n in ${age_arr[@]};do
		if [[ $n -lt 20 ]];then
			tw_down=$(( $tw_down+1 ))
		elif [[ $n -gt 30 ]];then 
			th_up=$(( th_up+1 ))
		else
			bet_tw_th=$(( bet_tw_th+1 ))
		fi
	done
	printf  "20+     :   %-10d   %-10f  \n" $tw_down   $(echo "scale=10; $tw_down/$player_count" | bc -l| awk '{printf "%f", $0}') 
	printf  "[20,30] :   %-10d   %-10f  \n" $bet_tw_th  $(echo "scale=10; $bet_tw_th/$player_count" | bc -l| awk '{printf "%f", $0}') 
	printf  "30+     :   %-10d   %-10f  \n" $th_up    $(echo "scale=10; $th_up/$player_count" | bc -l| awk '{printf "%f" , $0}') 

}

function get_pos {
	count_set=0
	pos_uniq_arr=($(echo "${pos_arr[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
	#echo ${pos_uniq_arr[*]}
	pos_uniq_count=()
	count=0
	for n in ${pos_uniq_arr[@]};do
		pos_uniq_count[$count]=0
		count=$(( $count+1 ))	
	done
	pos_arr_i=0
	for n in ${pos_arr[@]};do
		pos_arr_i=0
		be_flag=0
		for t in ${pos_uniq_arr[@]};do
			if [[ $t == $n ]];then
				pos_uniq_count[$pos_arr_i]=$((${pos_uniq_count[$pos_arr_i]}+1))
				be_flag=1
				break
			else
				pos_arr_i=$(($pos_arr_i+1))
			fi
		done
	done
	count=0
	for n in ${pos_uniq_count[@]};do
		printf  "%-30s     :   %-10d   %-10f  \n" ${pos_uniq_arr[$count]}  $n   $(echo "scale=10; $n/$player_count" | bc -l| awk '{printf "%f", $0}') 
		count=$(($count+1))
	done
}
function get_length_name {
	max_arr=()
	max_flag=0
	min_arr=()
	min_flag=0
	count=0
	length_max=0
	length_min=100
	#echo $player_count
	while [[ $count -lt $player_count ]];do
		with_star_name=${pl_arr[$count]}
		without_star_name=${with_star_name[@]//\*/ }  
		without_space_name=${without_star_name[@]// /}
		pl_arr[$count]=$without_star_name
		#echo ${age_arr[$count]}
		if [[ ${#without_space_name} -gt $length_max  ]];then
			length_max=${#without_space_name}
			max_count=$count
			max_flag=0
			max_arr[$max_flag]=$count
		elif [[ ${#without_space_name} -eq $length_max ]];then
			max_flag=$(($max_flag+1))
			max_arr[$max_flag]=$count
		fi

		if [[ ${#without_space_name} -lt $length_min  ]];then
			length_min=${#without_space_name}
			min_count=$count
			min_flag=0
			min_arr[$min_flag]=$count
		elif [[ ${#without_space_name} -eq $length_min ]];then
			min_flag=$(($min_flag+1))
			min_arr[$min_flag]=$count
		fi
	
		count=$(($count+1))
	done
	#echo $min_count	
	for n in ${max_arr[@]};do
		echo ${pl_arr[$n]}
	done 
	for n in ${min_arr[@]};do
		echo ${pl_arr[$n]}
	done 

}

function get_age_name {
	count=0
	length_max=0
	length_min=100
	while [[ $count -lt $player_count ]];do
		age=${age_arr[$count]}
		if [[ $age -gt $length_max  ]];then
			length_max=$age
			max_count=$count
		fi

		if [[ $age -lt $length_min  ]];then
			length_min=$age
			min_count=$count
		fi
		count=$(( $count+1 ))
	done
	#echo $max_count
	#echo $min_count	
	echo ${pl_arr[$max_count]}
	echo ${pl_arr[$min_count]}
}
	#echo $line | sed 's/\^I/\t/g'
deal_with_tsv_file $1
echo "-------------------------------------"
get_age 
echo "-------------------------------------"
get_pos
echo "-------------------------------------"
get_length_name
echo "-------------------------------------"
get_age_name
















