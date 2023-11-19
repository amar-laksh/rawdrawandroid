#!/bin/bash


get-adb-devices-list() {
    adb devices | grep -v "List of devices attached" | grep -v "daemon" | grep -v "^$" | grep -c .
}

echo "device count: $(get-adb-devices-list)"
while [ "$(get-adb-devices-list)" -eq 0 ]; do
    echo "Waiting for the device..."
    sleep 0.5
done

IP_ADDRESS=$(sudo adb shell ip addr show  wlan0 | grep "192.168.*.*" | awk -F ' ' '{print $2}' | cut -d '/' -f1)


connect-adb-tcp () {
    echo "Connect to the device...$IP_ADDRESS" && \
    sudo adb tcpip 5555 && \
        sudo adb connect "${IP_ADDRESS}"
}

connect-adb-tcp
