use_op(){
  # Check if op (1Password CLI) is installed
  if ! command -v op &> /dev/null; then
    echo "1Password CLI is not installed"
    return 1
  fi

  # Check if user is logged in to 1Password CLI
  if ! op whoami &> /dev/null; then
    echo "Please login to 1Password CLI using 'op signin'"
    return 1
  fi

  # check for template file(s) in the current directory (looks for .oprc, and .envrc.tmpl files, may add more in the future)
  local template_files=()
  for file in .envrc.op .oprc .envrc.tmpl; do
    if [ -f "$file" ]; then
      template_files+=("$file")
    fi
  done

  # check if there are any template files
  if [ ${#template_files[@]} -eq 0 ]; then
    echo "No template files found in the current directory, please create a .envrc.op, .oprc, or .envrc.tmpl file"
    return 1
  fi

  # For each template file found load the secrets into the environment
  echo "Loading secrets referenced in the template files ${template_files[@]} from 1Password into the environment"
  direnv_load op run --env-file "${template_files[@]}" --no-masking -- direnv dump
}
# Watch for changes in the template files
watch_file .envrc.op .oprc .envrc.tmpl