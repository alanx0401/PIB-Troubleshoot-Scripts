#!  /bin/sh
sleep 60
while true; do
  if ifconfig wlxe4fac4f574a2 | grep -q "inet"; then
    echo "all ok!"
  else
    nmcli n off
    sleep 5
    nmcli n on
  fi
  sleep 20
done
