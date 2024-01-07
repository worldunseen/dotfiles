# Managing Secrets

1. Create variable files in this directory in plain text.
2. Run `ansible-vault encrypt a.yaml b.yaml ...`.
3. Set and confirm a new vault password. All files will now be encrypted and share the same password to decrypt.

Running `setup.sh` should automatically pass these secrets as variables and prompt for a vault password.

See [Ansible documentation](https://docs.ansible.com/ansible/latest/vault_guide/vault_encrypting_content.html#encrypting-files-with-ansible-vault) for details.

