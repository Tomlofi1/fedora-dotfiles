#!/usr/bin/env bash

# CAVA
if ! pgrep -f "cool-retro-term.*cava" >/dev/null; then
  cool-retro-term -e cava &
fi

sleep 1

# BTOP
if ! pgrep -f "cool-retro-term.*btop" >/dev/null; then
  cool-retro-term -e btop &
fi

sleep 1

# FASTFETCH + shell
if ! pgrep -f "cool-retro-term.*fastfetch" >/dev/null; then
  cool-retro-term -e bash -c "fastfetch; exec bash" &
fi
