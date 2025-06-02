function join() {
  # we'd like this stream aware. TBD
  local d=${1:-} f=${2:-}
  printf %s "${f[0]}"
  shift 2 || true
  printf %s "$f" "${@/#/$d}"
}

function lines() {
  wc -l "${1:?no input for counting lines}"| cut -d' ' -f1
}
function num_file_in_dir {
  local d="${1:?no directory supplied}"
  # shellcheck disable=SC2012
  ls -f "${d}" | wc -l
}