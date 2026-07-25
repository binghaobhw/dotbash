#!/bin/bash
# Status line: Pro/Max rate limit usage.
# rate_limits fields only appear for claude.ai subscribers after the first
# API response in a session; each window may be independently absent.
# Falls back to session cost (cost.total_cost_usd) for API-key users.

input=$(cat)

model_name=$(echo "$input" | jq -r '.model.display_name // empty')

five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# 32 green / 33 yellow / 31 red, by usage percentage
color_for_pct() {
    local pct_int=${1%.*}
    if [ "$pct_int" -ge 90 ]; then
        echo 31
    elif [ "$pct_int" -ge 70 ]; then
        echo 33
    else
        echo 32
    fi
}

parts=()
if [ -n "$model_name" ]; then
    parts+=("$(printf "\033[35m%s\033[0m" "$model_name")")
fi
if [ -n "$five_hour" ]; then
    color=$(color_for_pct "$five_hour")
    reset_fmt=$(date -r "${five_hour_reset%.*}" "+%H:%M" 2>/dev/null)
    parts+=("$(printf "\033[%sm5h:%s%%(%s)\033[0m" "$color" "$five_hour" "$reset_fmt")")
fi
if [ -n "$seven_day" ]; then
    color=$(color_for_pct "$seven_day")
    reset_fmt=$(date -r "${seven_day_reset%.*}" "+%m-%d" 2>/dev/null)
    parts+=("$(printf "\033[%sm7d:%s%%(%s)\033[0m" "$color" "$seven_day" "$reset_fmt")")
fi

if [ ${#parts[@]} -eq 0 ]; then
    cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
    if [ -n "$cost" ]; then
        parts+=("$(printf "\033[36m\$%.4f\033[0m" "$cost")")
    fi
fi

IFS=' '
printf "%s" "${parts[*]}"
