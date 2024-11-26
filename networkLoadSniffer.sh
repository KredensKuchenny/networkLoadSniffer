#!/bin/bash

INTERVAL="1"  #update interval in seconds
NETWORKINTERFACE="ens18" #network interface
INCOMINGTRAFFIC="40" #incoming traffic in Mibt/s
INCOMINGTRAFFICPPS="400000" #incoming traffic in PPS/s
DELAYAFTERIMACT="30" #delay after network pick in seconds
NUMBEROFPACKETS="100000" #number of captured packets

while true
do

        CURRENTDATE=`date +%d-%m-%Y-%T` #current date (don't change it)

        RP1=`cat /sys/class/net/$NETWORKINTERFACE/statistics/rx_packets` #number of packets received
        RB1=`cat /sys/class/net/$NETWORKINTERFACE/statistics/rx_bytes` #number of bytes received

        sleep $INTERVAL

        RP2=`cat /sys/class/net/$NETWORKINTERFACE/statistics/rx_packets` #number of packets received
        RB2=`cat /sys/class/net/$NETWORKINTERFACE/statistics/rx_bytes` #number of bytes received

        RXPPS=`expr $RP2 - $RP1` #pkts/s
        RBPS=`expr $RB2 - $RB1`
        RMIBTS=`expr $RBPS / 131072` #Mibt/s

        if [ $RMIBTS -gt $INCOMINGTRAFFIC ] || [ $RXPPS  -gt $INCOMINGTRAFFICPPS ]
        then 
                tcpdump -n -i $NETWORKINTERFACE -c $NUMBEROFPACKETS -w $RMIBTS-Mibt-$RXPPS-PPS-$CURRENTDATE.pcap
                sleep $DELAYAFTERIMACT
        fi

done