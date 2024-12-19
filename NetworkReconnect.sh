#!/bin/bash
sleep 60
interface=$(ifconfig | grep -o "^wlx\w*")
echo "Interface is ${interface}."
while true; do
  if ifconfig ${interface} | grep -q "inet"; then
    echo "all ok!"
  else
    nmcli n off
    sleep 5
    nmcli n on
  fi
  sleep 20
done
