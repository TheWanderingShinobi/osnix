#!/bin/bash

# Specific directory to open Neovim
# specific_directory="/path/to/your/specific/directory"

specific_directory="~/1-Frontdoor/1-Home/2-Personal/1-Second-Brain"

# Launch Neovim in the specified directory and open in insert mode
nvim "+cd $specific_directory" -c "startinsert" -c "Telekasten"

#Replace /path/to/your/specific/directory with the actual path to the directory where you want to open Neovim.

#This script sets the directory using cd within Neovim (+cd $specific_directory), starts in insert mode (-c "startinsert"), and then types "Telekasten" in insert mode (-c "Telekasten").

#Save this script in a file (e.g., neovim_telekasten.sh), make it executable (chmod +x neovim_telekasten.sh), and then run it (./neovim_telekasten.sh). It will open Neovim in the specified directory in insert mode with "Telekasten" already typed. Adjust the directory path as per your requirement.

