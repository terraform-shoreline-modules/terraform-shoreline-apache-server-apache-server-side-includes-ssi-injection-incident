
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache Server Side Includes (SSI) Injection Incident.
---

Apache Server Side Includes (SSI) Injection is a security incident that happens when an attacker injects malicious code or scripts in the server-side includes of an Apache web server. This vulnerability allows the attacker to execute arbitrary code or commands on the server, leading to unauthorized access, data loss, or other security breaches. This type of incident can be prevented by implementing secure coding practices, using input validation and sanitization techniques, and keeping web servers updated with the latest security patches.

### Parameters
```shell
export PATH_TO_APACHE_CONFIG="PLACEHOLDER"

export APACHE_PORT="PLACEHOLDER"

export PATH_TO_APACHE_ACCESS_LOG="PLACEHOLDER"

export PATH_TO_APACHE_ERROR_LOG="PLACEHOLDER"

export PATH_TO_HTDOCS="PLACEHOLDER"

export PATH_TO_BACKUP_CONFIG="PLACEHOLDER"

export PATH_TO_APACHE_CONF_FILE="PLACEHOLDER"
```

## Debug

### Check the Apache configuration file for SSI support
```shell
grep -i "ssi" ${PATH_TO_APACHE_CONFIG}
```

### Check if the Apache server is running and listening on the expected port
```shell
systemctl status apache2.service

sudo netstat -tuln | grep ${APACHE_PORT}
```

### Check the Apache access log for any suspicious requests
```shell
tail -f ${PATH_TO_APACHE_ACCESS_LOG}
```

### Check the Apache error log for any SSI-related errors
```shell
tail -f ${PATH_TO_APACHE_ERROR_LOG} | grep -i "ssi"
```

### Check if there are any unauthorized modifications to SSI-enabled files
```shell
find ${PATH_TO_HTDOCS} -name "*.shtml" -exec grep -Hn "<!--#" {} \;
```

### Check for any unauthorized modifications to critical system files
```shell
sudo find / -name "*.php" -exec grep -Hn "system(" {} \;
```

### Check if there are any unauthorized modifications to the Apache configuration file
```shell
diff ${PATH_TO_APACHE_CONFIG} ${PATH_TO_BACKUP_CONFIG}
```

### Check if any unauthorized users have SSH access to the server
```shell
grep -i "ssh" /var/log/auth.log
```

## Repair

### Update the Apache configuration file to disable the use of Server Side Includes (SSI) and only allow the use of certain safe directives.
```shell


#!/bin/bash



# Define variables

APACHE_CONF_PATH=${PATH_TO_APACHE_CONF_FILE}



# Update Apache configuration file

sed -i 's/^\s*AddHandler\s+.*\s+ssi\s*$/# AddHandler cgi-script .cgi/' "$APACHE_CONF_PATH"

sed -i 's/^\s*Options\s+.*\s+Includes\s*$/Options -Includes/' "$APACHE_CONF_PATH"


```