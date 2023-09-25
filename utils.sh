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

function error() {
  echo -n "\033[0;31m$(date -u +"%Y-%m-%dT%H:%M:%SZ") ERROR:\033[0m ${*}"  >&2
  return 255 # by using this code, if an assertion occurs xargs will immediately halt
}

function warn() {
  echo -n "\033[1;33m$(date -u +"%Y-%m-%dT%H:%M:%SZ") WARN:\033[0m ${*}"  >&2
}
