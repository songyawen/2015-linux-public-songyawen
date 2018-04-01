#!/bin/bash
function quality_compress {
	image_original_dir=$1
	image_object_dir=$2
	quality_num=$3
	image_format=$(identify -format "%m" $image_original_dir)
	if [[ $image_format == "JPEG" ]]; then
		echo "compressing........";
		$(convert $image_original_dir -quality $quality_num $image_object_dir)
	#else
	#	echo "we only compress the image with JPEG format"
	fi
}

function quality_resize {
	image_original_dir=$1
	image_object_dir=$2
	resize_type=$3
	quality_num=$4
	image_format=$(identify -format "%m" $image_original_dir ) 
        if [[ $image_format == "JPEG" || $image_format == "SVG" || $image_format == "PNG" ]]; then
                 echo "resizing........";
	 	 if [[ $resize_type == "p" ]];then
			# to do check imput
			$(convert -resize $quality_num"%" $image_original_dir  $image_object_dir);
		 elif [[ $resize_type == "h" ]];then
			 $(convert -resize "x"$quality_num $image_original_dir $image_object_dir);
		 elif [[ $resize_type == "w" ]];then
			 $(convert -resize $quality_num $image_original_dir $image_object_dir);
		 else
			 echo "wrong input :("
		 fi
        # else
         #        echo "we only compress the image with JPEG/SVG/PNG format"
         fi
 }
function add_your_text {
	image_original_dir=$1
	image_target_dir=$2
	your_text=$3
	font_size=$4
	text_color=$5
	text_position=$6
	text_pixel=$7
	$(convert $image_original_dir -gravity $text_position -fill $text_color -pointsize $font_size -draw "text $text_pixel '$your_text'" $image_target_dir)
	echo "convert $image_original_dir -gravity $text_position -fill $text_color -pointsize $font_size -draw \"text $text_pixel '$your_text'\" $image_target_dir"

	
}
function rename {
	image_original_name=$1
	image_target_name=$2
	rename_type=$3
	xxx=$(echo $image_original_name | grep -oP '\.\w+$')		
	yyy=$(echo $image_original_name | grep -oP '(?<=/)[^/]+(?=\.)') 
	zzz=$(echo $image_original_name | grep -oP '^.+(?=/)')

	if [[ $rename_type == 'before' ]];then
		$(convert $image_original_name $zzz/$image_target_name$yyy$xxx)
	fi
	
	if [[ $rename_type == 'after' ]];then
		$(convert $image_original_name $zzz/$yyy$image_target_name$xxx)
	fi

}
function convert_image {
	image_original_dir=$1
	target_format=$2
	image_format=$(identify -format "%m" $image_original_dir)
	xxx=$(echo $image_original_dir | grep -oP '\.\w+$')		
	yyy=$(echo $image_original_dir | grep -oP '(?<=/)[^/]+(?=\.)') 
	zzz=$(echo $image_original_dir | grep -oP '^.+(?=/)')
	if [[ $image_format == "PNG" || $image_format == "SVG" ]]; then
		$(convert $image_original_dir $zzz/$yyy.$target_format)
	#else
	#	echo " wrong input:("
	fi
}



function one_file_deal {
	if [[ $1 == "compress" ]];then
		quality_compress $2 $3 $4
	elif [[ $1 == "resize" ]];then
		quality_resize $2 $3 $4 $5 
	elif [[ $1 == "add_text" ]];then
		add_your_text $2 $3 $4 $5 $6 $7 $8
	elif [[ $1 == "rename" ]];then
		rename $2 $3 $4
	elif [[ $1 == "convert" ]];then 
		convert_image $2 $3
	else
		echo " input :("
	fi
}
function batch_processing {
	arg_len=$#
	mmm=$(echo $* | sed  -e 's/\d001//g')
	arg_array=($mmm)
	origin_dir=${arg_array[1]}
	all_file=$(find $origin_dir)
	object_dir=${arg_array[2]}
	for n in ${all_file[@]};do
		arg_array[1]=$n
		if [[ $1 != 'rename' &&  $1 != 'convert' ]];then
		xxx=$(echo $n | grep -oP '\.\w+$')		
		yyy=$(echo $n | grep -oP '(?<=/)[^/]+(?=\.)') 
	#echo $image_format
			arg_array[2]=$object_dir$yyy$xxx
		fi
		format_file_res=($(file ${arg_array[1]}))
		format_file=${format_file_res[1]}
		if [[ $format_file == "PNG" || $format_file == "SVG" || $format_file == "JPEG" ]]; then
		one_file_deal ${arg_array[*]}
	fi
	done
}


#function help_fun {




#}

if [[ $1 == "bp" ]];then
	arg_len=$#
	arg_arr=($*)
	batch_processing ${arg_arr[*]:1:$arg_len}
elif [[ $1 == 'np' ]];then
	str=$*
	str=${str[@]// /*}
	str=${str[@]//:/ }
	commands=($str)
	flag=0
	for i in ${commands[@]};do
	#	echo $i
		if [[ $flag != 1 ]];then
			flag=1
		else
		tttt=$(echo ${i[@]//\*/ })
		com=($tttt)
		len=${#com[@]}
 		batch_processing ${com[@]:1:$len}
		fi
	done

else
	echo "bash image_processing.sh"
	echo "bp batch process "
	echo "bp args"
 	echo "np multi_command batch process"
	echo "   np *bp args bp args *bp args. ...... "
	echo "args:"
 	echo "rename original_path your_string [before|after]"
 	echo "	before : prefix"
 	echo "	after  : suffix "
 	echo "resize original_path destination_path [p|h|w] a_number"
 	echo "	p : percentage"
 	echo "	h : according to hight" 
 	echo "	w : according to weight" 
 	echo "convert orignal_path dest_image_format"
 	echo "compress orignal_path destination_path quality_number"
 	echo "add_text  original_path destination_path watermark_text font_size text_color text_position  distance_pixel"
fi

