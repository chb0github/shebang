
cache() {
  local home=${HOME:-"$(echo ~)"}
  local cache_dir="${home}/.cache/${1:?you must name your cache}"
  local file
  mkdir -p "${cache_dir}"
  file="${cache_dir}/$(printf "%s" "${@}")"
  if test -f "${file}" && test $(($(date +%s) - $(date -r "$file" +%s))) -le 1800 ; then
    cat "${file}"
  else
    "${@}" | tee "${file}"
  fi
}
