#!/usr/bin/env bash
#
# Wrapper around package managers

usage() {
  cat << EOF
Usage: pkg <command>

Commands:
  pkg search <package>
  pkg install <package>
  pkg remove <package>
  pkg upgrade
EOF
}

main() {
  for arg in "$@"; do
    shift
    case "$arg" in
      "--help") set -- "$@" "-h" ;;
      "--with") set -- "$@" "-w" ;;
      *)        set -- "$@" "$arg"
    esac
  done

  WITH=${PKG_CMD:-pacman}

  OPTIND=1
  while getopts "hw:" opt
  do
    case "$opt" in
      "h") usage; exit 0 ;;
      "w") WITH=${OPTARG} ;;
      "?") usage >&2; exit 1 ;;
    esac
  done
  shift $(expr $OPTIND - 1)

  $WITH "$@"
}

duplicate() {
  eval "$(echo "$2()"; declare -f $1 | tail -n +2)"
}

pacman() {
  case "$1" in
    i|install)
      CMD="-S"
      ;;
    r|remove)
      CMD="-R"
      ;;
    u|upgrade)
      CMD="-Syu"
      ;;
    s|search)
      CMD="-Ss"
      ;;
    *)
      CMD="$1"
      ;;
  esac
  shift
  command "$FUNCNAME" "$CMD" "$*"
}

npm() {
  case "$1" in
    r|remove)
      CMD="uninstall"
      ;;
    *)
      CMD="$1"
      ;;
  esac
  shift
  command "$FUNCNAME" "$CMD" "$*"
}

# Function alias
duplicate "pacman" "pacaur"
duplicate "npm" "pip"

main "$@"
