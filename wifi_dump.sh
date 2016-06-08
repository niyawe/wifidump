#!/bin/sh
#author: minus42

echo "Generating dump, plaeas hold the line!"

name=$(networksetup -getcomputername)
interface=$(networksetup -listallhardwareports | cut -d : -f2 -s | grep -A 1 Wi-Fi | sed -n 2p | sed  s/\ //g)
own_mac=$(ipconfig getpacket $interface | sed -n 12p | cut -c 10-27)
ssid=$(exec /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | sed -n 13p |  cut -d: -f 2)
bssid=$(exec /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | sed -n 12p |  cut -d: -f 2-7)
tx_rate=$(exec /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | sed -n 7p |  cut -d: -f 2)
channel=$(exec /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | sed -n 15p |  cut -d: -f 2 |cut -d, -f 1)
bandwidth=$(exec /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | sed -n 15p |  cut -d: -f 2 |cut -d, -f 2)
iperf=$(exec iperf3 -c linux.uni-koblenz.de | sed -n 16p | cut -d ' ' -f13-14)

if [ $channel -lt 36 ]
	then frequency="2,4 GHz"
	else frequency="5 GHz"
fi

echo
echo Name: $name
echo MAC: $own_mac
echo SSID: $ssid
echo BSSID: $bssid
echo TxRate: $tx_rate MBit/s
echo Frequency: $frequency
echo Channel: $channel
echo Bandwidth: $bandwidth MHz
echo Performance: $iperf
echo
echo proudly presented by minus42