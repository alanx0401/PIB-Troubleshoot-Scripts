# Step by step guide for network reconnect script.
1. Login to ccplsuperadmin
2. Run "sudo nano /etc/init.d/reconnect"
3. Paste below code into the editor:

```sh
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
```
4. Save and close with CTL+X then Y
5. Run  "sudo chmod +x /etc/init.d/reconnect"
6. Run "sudo crontab -e"
7. Add below code to a new line at end of file

`@reboot /etc/init.d/reconnect`

8. Save and close with CTL+X then Y
9. Reboot device
10. To verify:
    1. Login to ccplsuperadmin
    2. Run " ps aux | grep "reconnect" "
    3. If you see " /bin/sh /etc/init.d/reconnect "  Then everything is working.

### Technical Explaination
The script will sleep for 60s before running everything else
The script will run ifconfig every 20s and see if there is valid ip addr on wifi dongle. If not it would turn the wifi off and on again and the cycle will repeat. The rest of the steps is to make sure the script will run on startup using cron