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
function nfiles {
  local d="${1:?no directory supplied}"
  # shellcheck disable=SC2012
  ls -f "${d}" | wc -l
}

function fnempty {
  local d="${1:?no directory supplied}"
  while IFS= read -r -d '' f; do
    test -s "${f}" && echo "${f}"
  done < <(find "${d}" -type f -print0)
}

function fempty {
  local d="${1:?no directory supplied}"
  while IFS= read -r -d '' f; do
    test ! -s "${f}" && echo "${f}"
  done < <(find "${d}" -type f -print0)
}
