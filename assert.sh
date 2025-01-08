function error() {
  echo -n "\033[0;31m$(date -u +"%Y-%m-%dT%H:%M:%SZ") ERROR:\033[0m ${*}"  >&2
  return 255 # by using this code, if an assertion occurs xargs will immediately halt
}

function warn() {
  echo -n "\033[1;33m$(date -u +"%Y-%m-%dT%H:%M:%SZ") WARN:\033[0m ${*}"  >&2
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
  assert "test -f ${1}" "${1} doesn't exist "
}

function assert_installed () {
  local application="${1:?No application to assert supplied}"
  assert "command -v ${application} >/dev/null" "you must install ${application}"
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
