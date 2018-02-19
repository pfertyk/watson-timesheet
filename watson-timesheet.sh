#!/usr/bin/env bash
temp_file=tempfile_timesheet_file

expect << EOD
set timeout 20
spawn ~/.local/bin/watson log -T $1 -m
send "s$temp_file'.log'\rq"
interact
expect eof
EOD

printf '%s TOTAL %s\n\n\n' $( printf '=%.0s' {1..45} ) $( printf '=%.0s' {1..48} ) > $temp_file'.report'
unbuffer ~/.local/bin/watson report -T $1 -m >> $temp_file'.report'
printf '\n\n%s DETAILS %s\n\n\n' $( printf '=%.0s' {1..45} ) $( printf '=%.0s' {1..46} ) >> $temp_file'.report'

cat $temp_file'.report' | \
	cat - $temp_file'.log' > $temp_file'.cat' && \
	mv $temp_file'.cat' $temp_file'.log'

cat $temp_file'.log' | aha > $temp_file'.html'
wkhtmltopdf $temp_file'.html' timesheet_`date +"%Y_%m"`.pdf

rm $temp_file*
