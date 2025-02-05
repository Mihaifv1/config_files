#!/bin/bash

artist=$(playerctl --player=spotify metadata xesam:artist 2>/dev/null)
title=$(playerctl --player=spotify metadata xesam:title 2>/dev/null)
position=$(playerctl --player=spotify position 2>/dev/null)

if [ -z "$artist" ] || [ -z "$title" ]; then
  echo "No song playing"
else
  # Verificăm și curățăm poziția pentru a evita erori
  position_clean=$(echo "$position" | awk '{printf "%.0f", $1}') # Rotunjim la cel mai apropiat întreg

  # Convertim în minute și secunde
  position_min=$((position_clean / 60))
  position_sec=$((position_clean % 60))
  position_formatted=$(printf "%d:%02d" $position_min $position_sec)

  echo "$artist - $title [$position_formatted]"
fi

