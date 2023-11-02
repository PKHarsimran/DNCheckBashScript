# DNCheckBashScript
This repository contains a Bash script designed to help users manage and inspect their Docker network environments. The script provides an easy-to-use command-line tool to list all Docker networks on a system and identify whether they are in use by any containers.


# Features

- **Network Usage Detection:** The script loops through all Docker networks and prints out whether each network is currently being used by running or stopped containers.
- **Default Network Skipping:** It intelligently skips default Docker networks (bridge, host, none) to prevent unnecessary alerts, as these networks are typically used by Docker internally.
- **Container Listing:** For networks that are in use, the script lists all associated container IDs and names, providing a detailed view of the network's utilization.
- **jq** Auto-Installation: The script checks if jq (a lightweight and flexible command-line JSON processor) is installed on the system and attempts to install it if it's missing.


# Prerequisites

- Docker installed and running on your system
- Bash shell environment
- Sudo privileges (if jq is not installed and needs to be automatically installed by the script)

1. Clone the repository to your local machine:
   
       git clone https://github.com/PKHarsimran/DNCheckBashScript.git

3. Navigate to the cloned directory:
   
        cd DNCheckBashScript
  
5. Make the script executable:

       chmod +x dncheck.sh

7. Run the script:

       ./dncheck.sh


    

