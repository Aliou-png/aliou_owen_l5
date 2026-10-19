#!/bin/bash

########################

#   chmod +x flash_pico.sh  --> make it a executable (only run once)
#   ./flash_pico.sh         --> to run

########################

# Stop the script immediately if any command fails
set -e

# Configure the CMake project and generate build files
cmake -S . -B build

# Compile the Pico project
cmake --build build

# Reboot the Pico into BOOTSEL mode so it can be flashed
picotool reboot -f -u

# Wait 1 second for the Pico to reconnect
echo "before sleep"
sleep 1
echo "after sleep"

# Flash the compiled ELF file onto the Pico
picotool load -f ./build/test/mytest.elf

# Reboot the Pico to start running the newly flashed program
picotool reboot -f

# Wait 2 seconds for the Pico's serial port to become available
sleep 2

# Open the Pico's serial connection
# Press Ctrl+A, then K, then Y to exit screen
# screen /dev/cu.usbmodem101 115200