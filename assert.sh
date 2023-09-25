function assert_file_not_empty() {
  local file=${1:?No file supplied}
  assert "test $(du "${file}" | sed -En 's/([0-9]+).*/\1/p') -gt 0" "Your file '${file}' is empty"
}

function assert() {

  if ! eval "${1}"; then
    error "${1}: ${2}"
  fi
}
