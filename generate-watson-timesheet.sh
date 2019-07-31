#!/usr/bin/env bash
files_and_tags=$1

separator () {
	printf '=%.0s' $(eval echo {1..$1})
}

while read line; do
	set -- $line # each line consists of a file name and a tag name
	file_name=$1; tag_name=$2
	temp_file=temp_timesheet_file_$file_name

	./watson-to-file.sh log $tag_name $temp_file
	./watson-to-file.sh report $tag_name $temp_file

	printf '%s TOTAL %s\n\n\n' $(separator 45) $(separator 48 ) > $temp_file.header1
	printf '\n\n%s DETAILS %s\n\n\n' $(separator 45) $(separator 48 ) >> $temp_file.header2

	cat $temp_file.header1 | cat - $temp_file.report | cat - $temp_file.header2 | cat - $temp_file.log \
		> $temp_file.all

	cat $temp_file.all | aha > $temp_file.html
	wkhtmltopdf $temp_file.html timesheet-`date +"%Y-%m"`-$file_name.pdf

	rm $temp_file*
done < $files_and_tags
