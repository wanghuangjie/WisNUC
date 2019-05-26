#!/bin/sh  
while true

do
  button=$(< /proc/BOARD_event)
#  echo $my_var
  if [ "$button" == "PWR ON" ]; then
    echo "power pushed"
    curl "http://localhost:3000/api/v1/commands/?cmd=toggle"
  fi
  sleep 3
done
