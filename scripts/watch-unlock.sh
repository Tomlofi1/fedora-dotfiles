#!/usr/bin/env bash

dbus-monitor --session \
  "type='signal',interface='org.gnome.ScreenSaver'" |
while read -r line; do
  if grep -q "ActiveChanged" <<< "$line"; then
    read -r state_line

    if grep -q "false" <<< "$state_line"; then
      sleep 1
      "$HOME/.local/bin/ensure-cyber-terminals.sh"
    fi
  fi
done
