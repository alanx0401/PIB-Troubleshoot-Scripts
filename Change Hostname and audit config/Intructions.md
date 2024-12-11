1. Create a folder
2. Create / Transfer `ansible.cfg` into the folder
```
[defaults]
host_key_checking = false
```
3. Enter this command
`export ANSIBLE_CONFIG=./ansible.cfg`
4. Create / Transfer `change_audit_conf_and_hostname.yml` into the folder
```yml
- hosts: WA14
  become: yes
  tasks:
  - name: change config for auditd.conf
    shell: "sudo sed -i -e '/max_log_file_action/s/keep_logs/rotate/g' -e '/space_left_action/s/email/syslog/g' -e '/admin_space_left_action/s/halt/syslog/g' /etc/audit/auditd.conf"
  - name: delete old audit logs
    shell: "sudo rm -r /var/log/audit/audit.log.*"
  - name: delete var tmp
    shell: "sudo rm -r /var/tmp/aide.cron.daily.old*"
  - name: change hostname
    shell: hostnamectl set-hostname {{ hostvars[inventory_hostname].new_hostname }}
```
**Note: change `hosts: WA14` to whichever group of devices you want to run on. E.g. `hosts: WA15`**

5. Transfer `inventory.ini` into the folder. It should look something like below:
```ini
[all:vars]
ansible_user=xxxx
[WA14]
10.x.x.x:xxxx new_hostname=xxx_xxx_WA14Bxx
10.x.x.x:xxxx new_hostname=xxx_xxx_WA14Bxx
```
6. Run `ansible-playbook -Kk -i inventory.ini change_audit_conf_and_hostname.yml` inside the folder
7. Enter the superadmin password **twice**
8. Wait for the reporting

## Technical Knowledge
In the `inventory.ini` the devices is separated by `[XXXX]` this is the Wards of each devices.

The script will do 3 things.
1. Cleanup the audit logs
2. Change the audit config
3. Cleanup the /var/tmp folder 