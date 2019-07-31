#!/usr/bin/expect -f
set watson_command [lindex $argv 0]
set tag [lindex $argv 1]
set temp_file [lindex $argv 2]
set timeout 20
spawn ~/.local/bin/watson $watson_command -T $tag -m
send -- "s$temp_file.$watson_command\rq"
expect eof
