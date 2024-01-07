#!/bin/bash
# Use nullglob in case there are no matching files
shopt -s nullglob

if ! command -v ansible-playbook &> /dev/null
then
  echo "Unable to find executable to run playbook, is Ansible installed?"
  exit 1
fi

# Include all YAML files from `secrets` folder as extra variables
secret_files=(secrets/*.yaml)
secret_files+=(secrets/*.yml)
secret_file_args="${secret_files[@]/#/-e @}"

# Ask for vault password if secret files exist
ask_vault_pass_flag=""
if [ -n "${secret_file_args}" ]
then
  ask_vault_pass_flag="--ask-vault-pass"
fi

command="ansible-playbook $@ ${secret_file_args} ${ask_vault_pass_flag} dotfiles.yaml"
echo "${command}"
eval -- "${command}"
