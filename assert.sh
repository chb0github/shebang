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
  
}

function assert_file_pattern() {
  local pattern="${1:?you must supply a pattern}"
  local msg="${2}"
  assert "! grep -m 1 -qvE '${pattern}' '${pattern}'" "${msg}"
}
