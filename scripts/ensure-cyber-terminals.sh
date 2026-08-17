#!/usr/bin/env bash

# Se já existem 4 Cool Retro Terms, não faz nada
COUNT=$(pgrep -fc "cool-retro-term")

if [ "$COUNT" -ge 4 ]; then
  exit 0
fi

# Fecha qualquer resto incompleto
pkill cool-retro-term 2>/dev/null

sleep 1

# Recria o grid inteiro bonitinho
"$HOME/.local/bin/cyber-grid.sh"