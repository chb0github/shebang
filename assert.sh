function error() {
  echo -n "\033[0;31m$(date -u +"%Y-%m-%dT%H:%M:%SZ") ERROR:\033[0m ${*}"  >&2
  return 255 # by using this code, if an assertion occurs xargs will immediately halt
}

function warn() {
  echo -n "\033[1;33m$(date -u +"%Y-%m-%dT%H:%M:%SZ") WARN:\033[0m ${*}"  >&2
}

function assert_zulu_time {
  local zulu_format='\d{4}-(?:0[1-9]|1[0-2])-(?:0[1-9]|[1-2]\d|3[0-1])T(?:[0-1]\d|2[0-3]):[0-5]\d:[0-5]\dZ'
  grep -qE "${zulu_format}" <<< "${1}" || error "'${1}' is not in zulu time"
}

function assert_file_not_empty() {
  local file=${1:?No file supplied}
  assert "test -s '${file}'" "Your file '${file}' is empty"
}

function assert() {

  if ! eval "${1}"; then
    error "${1}: ${2}"
  fi
}

function assert_file_exists() {
  if ! test -f "${1:?no filed supplied to assert}"; then
    error "${1} doesn't exist "
  fi
}

function assert_number {
  if ! grep -qE '[0-9]{1,}' <<< "${1}"; then
    error "${1} is not a number"
  fi
}

function assert_installed () {
  local application="${1:?No application to assert supplied}"
  if ! command -v "${application}" >/dev/null; then
    error "${application} not installed"
  fi
}

function assert_not_empty() {
  local file=${1:?No file supplied}
  assert "test -s ${1}"
}

function assert_file_pattern() {
  local pattern="${1:?you must supply a pattern}"
  local msg="${2}"
  assert "! grep -m 1 -qvE '${pattern}' '${pattern}'" "${msg}"
}

function assert_dir {
  local d=${1:?No directory supplied}
  assert "test -d '${d}'" "${d} is not a directory"
}
