#!/bin/sh  
while true

do
  button=$(< /proc/BOARD_event)
  if [ "$button" == "PWR ON" ]; then
    # 相关按钮还包括 copy on、rst2df on、nobtn on
    echo "power pushed"
    curl "http://localhost:3000/api/v1/commands/?cmd=toggle"
  fi
  sleep 3
done
