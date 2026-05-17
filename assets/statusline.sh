#!/bin/bash
# Claude Code statusline — caveman badge, cwd, session + week usage % with reset times.
# Colour ramp on used%: <50 green, 50-74 yellow, 75-89 orange, ≥90 red.

input=$(cat)
jget() { printf '%s' "$input" | jq -r "$1 // empty" 2>/dev/null; }

RESET=$'\033[0m'
GREY=$'\033[38;5;245m'
GREEN=$'\033[38;5;114m'
YELLOW=$'\033[38;5;221m'
ORANGE=$'\033[38;5;214m'
RED=$'\033[38;5;203m'

colour() {
  local u=$1
  if   [ "$u" -ge 90 ]; then printf '%s' "$RED"
  elif [ "$u" -ge 75 ]; then printf '%s' "$ORANGE"
  elif [ "$u" -ge 50 ]; then printf '%s' "$YELLOW"
  else                       printf '%s' "$GREEN"
  fi
}

segment() {
  local label=$1 pct=$2 reset_iso=$3 fmt=$4
  [ -z "$pct" ] && return
  local pct_int reset_str col
  pct_int=$(printf '%.0f' "$pct")
  col=$(colour "$pct_int")
  reset_str=""
  if [ -n "$reset_iso" ]; then
    case "$reset_iso" in
      [0-9]*[!0-9]*|*[!0-9]*) reset_str=$(date -d "$reset_iso" +"$fmt" 2>/dev/null) ;;
      [0-9]*)                 reset_str=$(date -d "@$reset_iso" +"$fmt" 2>/dev/null) ;;
    esac
  fi
  if [ -n "$reset_str" ]; then
    printf "${GREY}%s:${RESET}${col}%d%%${RESET} ${GREY}(%s)${RESET}" "$label" "$pct_int" "$reset_str"
  else
    printf "${GREY}%s:${RESET}${col}%d%%${RESET}" "$label" "$pct_int"
  fi
}

caveman=""
for candidate in \
  "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"/plugins/cache/caveman/caveman/*/hooks/caveman-statusline.sh \
  "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"/plugins/marketplaces/caveman/hooks/caveman-statusline.sh
do
  if [ -f "$candidate" ]; then
    caveman=$(bash "$candidate" 2>/dev/null)
    break
  fi
done

CYAN=$'\033[38;5;81m'
model=$(jget '.model.display_name')
model_part=""
[ -n "$model" ] && model_part=$(printf "${CYAN}%s${RESET}" "$model")

cwd=$(jget '.workspace.current_dir')
cwd_part=""
[ -n "$cwd" ] && cwd_part=$(printf "${GREY}%s${RESET}" "$(basename "$cwd")")

MAGENTA=$'\033[38;5;177m'
serena_running=false
case "$OSTYPE" in
  msys*|cygwin*)
    if powershell.exe -NoProfile -Command \
      "if (Get-CimInstance Win32_Process | Where-Object { \$_.CommandLine -like '*serena*start-mcp-server*' }) { exit 0 } else { exit 1 }" \
      2>/dev/null; then
      serena_running=true
    fi
    ;;
  *)
    if pgrep -af 'start-mcp-server' 2>/dev/null | grep -q 'serena'; then
      serena_running=true
    fi
    ;;
esac
serena_part=""
if [ "$serena_running" = true ]; then
  serena_count=0
  transcript=$(jget '.transcript_path')
  if [ -n "$transcript" ] && [ -f "$transcript" ]; then
    serena_count=$(jq -r '
      select(.type=="assistant")
      | .message.content[]?
      | select(.type=="tool_use" and (.name | startswith("mcp__plugin_serena_serena__")))
      | .name
    ' "$transcript" 2>/dev/null | wc -l)
  fi
  serena_part=$(printf "${GREY}serena:${RESET}${MAGENTA}%d${RESET}" "$serena_count")
fi

sn_reset=$(jget '.rate_limits.five_hour.reset_time // .rate_limits.five_hour.resets_at // .rate_limits.five_hour.reset_at')
wk_reset=$(jget '.rate_limits.seven_day.reset_time // .rate_limits.seven_day.resets_at // .rate_limits.seven_day.reset_at')

sn=$(segment sn "$(jget '.rate_limits.five_hour.used_percentage')"  "$sn_reset" "%H:%M")
wk=$(segment wk "$(jget '.rate_limits.seven_day.used_percentage')" "$wk_reset" "%Y/%m/%d %H:%M")

SEP="${GREY} | ${RESET}"
parts=()
[ -n "$caveman"     ] && parts+=("$caveman")
[ -n "$model_part"  ] && parts+=("$model_part")
[ -n "$cwd_part"    ] && parts+=("$cwd_part")
[ -n "$serena_part" ] && parts+=("$serena_part")
[ -n "$sn"          ] && parts+=("$sn")
[ -n "$wk"          ] && parts+=("$wk")

result=""
for p in "${parts[@]}"; do
  if [ -z "$result" ]; then result="$p"; else result="${result}${SEP}${p}"; fi
done
printf '%b' "$result"
