

#!/bin/bash



# Define variables

APACHE_CONF_PATH=${PATH_TO_APACHE_CONF_FILE}



# Update Apache configuration file

sed -i 's/^\s*AddHandler\s+.*\s+ssi\s*$/# AddHandler cgi-script .cgi/' "$APACHE_CONF_PATH"

sed -i 's/^\s*Options\s+.*\s+Includes\s*$/Options -Includes/' "$APACHE_CONF_PATH"