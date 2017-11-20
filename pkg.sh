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

  if command -v apt      >/dev/null; then PKG_SYS="apt"
  elif command -v dnf    >/dev/null; then PKG_SYS="dnf"
  elif command -v yum    >/dev/null; then PKG_SYS="yum"
  elif command -v brew   >/dev/null; then PKG_SYS="brew"
  elif command -v pacman >/dev/null; then PKG_SYS="pacman"
  elif command -v zypper >/dev/null; then PKG_SYS="zypper"
  fi
  WITH=${PKG_CMD:-$PKG_SYS}

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

  case "$1" in
    "s") shift; set -- "search"  "$@" ;;
    "i") shift; set -- "install" "$@" ;;
    "r") shift; set -- "remove"  "$@" ;;
    "u") shift; set -- "upgrade" "$@" ;;
  esac

  $WITH "$@"
}

duplicate() {
  eval "$(echo "$2()"; declare -f $1 | tail -n +2)"
}

pacman() {
  case "$1" in
    "search")  shift; set -- "-Ss"  "$@" ;;
    "install") shift; set -- "-S"   "$@" ;;
    "remove")  shift; set -- "-R"   "$@" ;;
    "upgrade") shift; set -- "-Syu" "$@" ;;
  esac
  command "$FUNCNAME" "$@"
}

npm() {
  case "$1" in
    "remove") shift; set -- "uninstall" "$@" ;;
  esac
  command "$FUNCNAME" "$@"
}

# Function alias
duplicate "pacman" "pacaur"
duplicate "npm" "pip"

main "$@"
