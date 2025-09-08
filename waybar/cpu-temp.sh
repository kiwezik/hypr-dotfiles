temp=$(sensors -j | jq '.["k10temp-pci-00c3"].Tctl.temp1_input | round')
echo "{\"text\": \"$temp°C\"}"
