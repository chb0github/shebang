function warn {
  highlight "WARN: ${1}" yellow "WARN" "${@:2}" >&2
}
function info {
  highlight "INFO: ${1}" green "INFO" "${@:2}" >&2
}
function error {
  highlight "ERROR: ${1}" red "ERROR" "${@:2}" >&2
}

function highlight {
  local string=${1:?you must give a string that needs highlighting}
  local color=${2:?you must supply a highlight color}

  declare -A colors=(
    [black]="0;30"
    [red]="0;31"
    [green]="0;32"
    [yellow]="0;33"
    [blue]="0;34"
    [magenta]="0;35"
    [cyan]="0;36"
    [white]="0;37"
  )

  # validate color explicitly to avoid unbound variable reference
  if test -z "${colors[${color}]:-}" ; then
    echo "Invalid color '$color', available colors: ${!colors[*]}" >&2
    return 1
  fi

  local color_code="\033[${colors[$color]}m"
  local reset_code="\033[0m"

  # replace words to highlight with ANSI sequences
  for word in "${@:3}"; do
    string=${string//${word}/${color_code}${word}${reset_code}}
  done

  echo -e "$string"
}
