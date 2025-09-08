check_network() {
    if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
        echo '{"text": "", "class": "connected"}'
    else
        echo '{"text": "", "class": "disconnected"}'
    fi
}

echo '{"text": "", "class": "checking"}'

check_network

while true; do
    sleep 20
    check_network
done
