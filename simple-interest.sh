#!/bin/sh
# POSIX-compatible script to calculate simple interest.
# Prompts for Principal, Annual rate (percent), and Time (years).
# Calculates Interest I = P * R% * T using bc, prints Interest and Total amount.

# Ensure bc is available
if ! command -v bc >/dev/null 2>&1; then
  printf 'Error: "bc" is required but not installed.\n' >&2
  exit 2
fi

# Read a value with prompt
read_value() {
  prompt="$1"
  varname="$2"
  printf "%s " "$prompt"
  # shellcheck disable=SC2034
  read -r val
  # Trim leading/trailing whitespace
  val="$(printf '%s' "$val" | awk '{$1=$1;print}')"
  printf '%s' "$val"
  eval "$varname=\"$val\""
}

# Simple numeric check (allows integers and decimals, optional leading +/−)
is_number() {
  case "$1" in
    ''|*[!0-9.+-]* ) return 1 ;;
    *.*.* ) return 1 ;;
    +|-) return 1 ;;
    *) return 0 ;;
  esac
}

# Prompt and validate Principal
printf 'Principal amount: '
read -r P
P="$(printf '%s' "$P" | awk '{$1=$1;print}')"
if [ -z "$P" ] || ! is_number "$P"; then
  printf 'Invalid principal amount. Enter a numeric value.\n' >&2
  exit 1
fi

# Prompt and validate Annual rate (%)
printf 'Annual rate (%%): '
read -r R
R="$(printf '%s' "$R" | awk '{$1=$1;print}')"
if [ -z "$R" ] || ! is_number "$R"; then
  printf 'Invalid annual rate. Enter a numeric value (percent).\n' >&2
  exit 1
fi

# Prompt and validate Time (years)
printf 'Time (years): '
read -r T
T="$(printf '%s' "$T" | awk '{$1=$1;print}')"
if [ -z "$T" ] || ! is_number "$T"; then
  printf 'Invalid time. Enter a numeric value for years.\n' >&2
  exit 1
fi

# Use bc to compute interest and total with 2 decimal places
# I = P * R/100 * T
interest=$(printf 'scale=4; (%s) * (%s) / 100 * (%s)\n' "$P" "$R" "$T" | bc -l 2>/dev/null)
if [ -z "$interest" ]; then
  printf 'Calculation error. Check input values.\n' >&2
  exit 3
fi
# Format to 2 decimal places
interest=$(printf '%s' "$interest" | awk '{printf "%.2f", $0}')

total=$(printf 'scale=4; (%s) + (%s)\n' "$P" "$interest" | bc -l 2>/dev/null)
if [ -z "$total" ]; then
  printf 'Calculation error computing total amount.\n' >&2
  exit 4
fi
# Format total
total=$(printf '%s' "$total" | awk '{printf "%.2f", $0}')

printf '\nInterest: %s\n' "$interest"
printf 'Total amount: %s\n' "$total"

exit 0
