
cache() {
  local file
  local home=${HOME:-"$(echo ~)"}
  test -d "$home/.cache/" || mkdir -p "$home/.cache/"
  file="$HOME/.cache/bb/$(printf "%s" "${@}")"
  if test -f "${file}" && test $(($(date +%s) - $(date -r "$file" +%s))) -le 1800 ; then
    cat "${file}"
  else
    "${@}" | tee "${file}"
  fi
}
