#!/usr/bin/env bash

# Queries Shodan for webpages with `/wp-admin/wp-install.php` accessible
# Opens all results in Firefox tabs for quick viewing

datename=$(date -Iseconds | tr : -) # File name
shodan download search "/wp-admin/wp-install.php" 2> /dev/null # Query Shodan for '/wp-admin/wp-install.php'
shodan parse --fields ip_str,port --separator : search.json.gz 2> /dev/null > wp.$datename # Parse archive
rm search.json.gz # Cleanup

# Format results to open with Firefox (make sure `firefox` is in $PATH)
sed -z -i 's]\n]/wp-admin/install.php -new-tab -url ]g' wp.$datename
sed -i -e 's_.*_firefox -new-tab -url &_' wp.$datename
sed -i "s/.\{0,15\}$//; /^$/d" wp.$datename

chmod u+x wp.$datename # Make runnable

printf "\nDone -- check or run ./wp.$datename\n"
