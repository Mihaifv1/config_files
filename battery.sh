#!/usr/bin/env bash

# Citește procentul din /sys/class/power_supply/BAT1/capacity
CAPACITY=$(cat /sys/class/power_supply/BAT1/capacity)

# Citește starea (Charging / Discharging / Full / Unknown)
STATUS=$(cat /sys/class/power_supply/BAT1/status)

# Poți simplifica statusul la C / D / F
if [ "$STATUS" = "Charging" ]; then
    STATUS="C"
elif [ "$STATUS" = "Discharging" ]; then
    STATUS="D"
elif [ "$STATUS" = "Full" ] || [ "$STATUS" = "Unknown" ]; then
    STATUS="F"
fi

# Afișează ceva simplu, ex: "C 73%"
echo "$STATUS $CAPACITY%"

