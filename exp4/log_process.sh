#!bin/bash

function read_file {
	file_path=$1
	i=0
	flag_col_name=1
	while read -r line;do
		if [[ $flag_col_name == 1 ]];then
			flag_col_name=0
		else
			str_arr=($line)
			if [[ ${#str_arr[@]} == 7 ]];then
				host[$i]=str_arr[0]
				logname[$i]=str_arr[1]
				time[$i]=str_arr[2]
				method[$i]=str_arr[3]
				url[$i]=str_arr[4]
				response[$i]=str_arr[5]
				byte[$i]=str_arr[6]
				referer[$i]=str_arr[7]
				useragent[$i]=str_arr[8]
			else
				echo "dirty data"
				echo $line
				echo ${#str_arr[@]}
			fi

		fi
		i=$(( $i+1 ))
		echo $i
	done < $file_path
	log_count=$i
}
function get_top_host {
	echo "done"
	host_arr_count=0
	host_ip_arr_count=0
	count=0
	while [[ $count -lt $log_count ]];do
		echo ${host[$count]}
		count=$(($count+1))
	done

}



read_file $1
echo "----------------------------"
get_top_host 
