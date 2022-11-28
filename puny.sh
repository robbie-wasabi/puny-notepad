#!/bin/bash

new() {
	now="$(date +'%m_%d_%Y')" 
	dir="../${now}"
	ext="md"

	# create dir if doesn't exist
	[ ! -f ${dir} ] && mkdir $dir

	title_date="$(date +'%m/%d/%Y')" 
	title="# ${name} ${title_date}"
	if [[ $style == todo ]]; then
		contents="${title}\n\n## Header\n\n[ ] item"
	else
		contents="${title}\n\n## Header"
	fi

	echo $contents

	seq=0
	for n in $(seq -w 01 99); do
		path="./${dir}/${name}_${n}.${ext}"
		[[ ! -f $path ]] && { printf "${contents}" > $path; break; }
	done

	echo "${file} created at path: ${path}"
}

while getopts ":n:s:o" optname
  do
	case "$optname" in
	  "n")
		name=$OPTARG;;
	  "s")
		style=$OPTARG;;
	  "o")
		should_open=1;;
	esac
  done

new

# open in vim
[ ! -z ${should_open} ] && vim ${path}
