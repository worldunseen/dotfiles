#!/bin/sh

if ! command -v ansible-playbook &> /dev/null
then
  echo "Unable to find executable to run playbook, is Ansible installed?"
  exit 1
fi

ansible-playbook dotfiles.yaml
