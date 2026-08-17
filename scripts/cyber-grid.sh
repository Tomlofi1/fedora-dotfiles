#!/usr/bin/env bash

export QT_QPA_PLATFORM=xcb

# Monitor principal DP-1:
# 1920x1080+1440+0
MON_X=1440
MON_Y=0
HALF_W=960
HALF_H=540

get_crt_windows() {
    wmctrl -lx |
        awk 'tolower($3) ~ /cool-retro-term/ {print $1}'
}

launch_and_get_window() {
    local before
    local after
    local new_id

    before="$(get_crt_windows)"

    "$@" >/dev/null 2>&1 &

    # Espera a janela efetivamente surgir no XWayland
    for _ in {1..50}; do
        sleep 0.1

        after="$(get_crt_windows)"

        new_id="$(
            comm -13 \
                <(printf '%s\n' "$before" | sed '/^$/d' | sort) \
                <(printf '%s\n' "$after"  | sed '/^$/d' | sort) |
                head -n1
        )"

        if [[ -n "$new_id" ]]; then
            echo "$new_id"
            return 0
        fi
    done

    return 1
}

echo "Abrindo CAVA..."
CAVA_ID=$(launch_and_get_window cool-retro-term -e cava)
wmctrl -ir "$CAVA_ID" -e "0,$MON_X,$MON_Y,$HALF_W,$HALF_H"

echo "Abrindo BTOP..."
BTOP_ID=$(launch_and_get_window cool-retro-term -e btop)
wmctrl -ir "$BTOP_ID" -e "0,$((MON_X + HALF_W)),$MON_Y,$HALF_W,$HALF_H"

echo "Abrindo FASTFETCH..."
FAST_ID=$(launch_and_get_window cool-retro-term -e "$HOME/.local/bin/fastfetch-shell")
wmctrl -ir "$FAST_ID" -e "0,$MON_X,$((MON_Y + HALF_H)),$HALF_W,$HALF_H"

echo "Abrindo terminal normal..."
TERM_ID=$(launch_and_get_window cool-retro-term)
wmctrl -ir "$TERM_ID" -e \
    "0,$((MON_X + HALF_W)),$((MON_Y + HALF_H)),$HALF_W,$HALF_H"