#!/bin/bash

# Function to check if jq is installed
check_and_install_jq() {
    if ! command -v jq &> /dev/null; then
        echo "jq could not be found, attempting to install..."
        # Detect the package manager and install jq
        if [[ -n "$(command -v apt-get)" ]]; then
            sudo apt-get update && sudo apt-get install -y jq
        elif [[ -n "$(command -v yum)" ]]; then
            sudo yum install -y jq
        elif [[ -n "$(command -v brew)" ]]; then
            brew install jq
        else
            echo "Package manager not detected. Please install jq manually." >&2
            exit 1
        fi
    fi
}

# Ensure jq is installed
check_and_install_jq

# Get all network IDs from Docker
network_ids=$(docker network ls -q)

# Loop over each network ID
for net_id in $network_ids; do
    # Inspect the network and store the result in a variable
    network_inspect=$(docker network inspect $net_id --format '{{json .}}')
    
    # Extract the network name and check if it's a default network
    network_name=$(echo $network_inspect | jq -r '.Name')
    if [[ "$network_name" == "bridge" || "$network_name" == "host" || "$network_name" == "none" ]]; then
        echo "Network $network_name ($net_id) is a default Docker network, skipping."
        continue
    fi

    # Extract the containers for the network
    containers=$(echo $network_inspect | jq -r '.Containers | to_entries | .[] | .value.Name + " (" + .key + ")"')

    # Check if there are any containers
    if [[ -z $containers ]]; then
        echo "Network $network_name ($net_id) is unused."
    else
        # Print the containers using the network
        echo "Network $network_name ($net_id) is used by the following containers:"
        echo "$containers" | sed 's/^/ - /' # Format each container entry with a dash for readability
    fi
done
