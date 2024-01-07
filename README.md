# worldunseen's dotfiles

Automatically configures all my settings using Ansible.

## TL;DR

1. Add your required Vault variable files to the `secrets` directory.
2. Run `setup.sh`.
3. Enter your `sudo` and Vault passwords.
4. Reboot.

## Requirements

- Fedora Workstation (GNOME)
- Ansible (`dnf install ansible`)
- User running Ansible should have `sudo` permissions

Tested on a Lenovo ThinkPad T14 Gen 4 (Intel) running Fedora 39.

## Roles

|     Role     |                                                  Description                                                  |
|:------------:|:-------------------------------------------------------------------------------------------------------------:|
| auth         | Installs and configures common tools I use for authentication.                                                |
| dconf        | Installs the required dependencies in order to use Ansible to edit dconf configurations.                      |
| development  | Installs and configures common tools I use for software development.                                          |
| flathub      | Enables Flathub repositories. Include as a role dependency when installing Flatpak applications from Flathub. |
| fonts        | Installs various fonts, including fonts required for `font_*` variable references.                            |
| gnome        | Installs and configures GNOME desktop settings and extensions to my liking.                                   |
| gpg_key      | Import GPG key an from armored private key.                                                                   |
| media_codecs | Installs libraries required to play audio/video. Enables VAAPI if supported (only on Intel for now).          |
| productivity | Umbrella role to install tools I use to be ‘productive.’                                                      |
| rpm_fusion   | Enables RPM Fusion repositories. Only supports Fedora.                                                        |

## Variables

### Global

#### Identity

- `full_name`: The desired user's full name. Defaults to `anonymous`
- `user_name`: The desired user's alias (can be different from the user). Defaults to `anon`
- `email`: The desired user's email address. Defaults to `anon@example.com`

#### Fonts

Variables are strings following the format `<Font Name> <Font Size>`. Make sure to include a role dependency on `fonts` if you are referencing any of these variables.

- `font_interface`: The font to use for application interfaces.
- `font_monospace`: The font to use for coding.
- `font_legacy`: The font to use for legacy (e.g. GNOME legacy title bars) use cases.

#### Hardware

- `ansible_processor_is_intel`: Boolean that is true if currently running hardware is detected as Intel.

### Roles

#### gpg_key

- `gpg_private_key` - The armored (ASCII) private key to import, represented as a string. Formatting should look like this:

  ```yaml
  gpg_private_key: |
    -----BEGIN PGP PRIVATE KEY BLOCK-----
    ...
    -----END PGP PRIVATE KEY BLOCK-----
  ```

  **Do not store this variable in plain text.** Use a solution like Ansible Vault to encrypt data at rest. See <secrets/README.md> for a potential approach.

#### rpm_fusion

- `rpm_fusion_non_free_is_enabled`: Boolean that enables non-free repositories if set to true. Defaults to false

## Make it your own

1. Fork/clone this repo.
2. Replace the contents of `dotfiles.yaml` with your own playbook. Feel free to reuse the roles!
3. Make changes to existing roles, or make new ones!

## Future roadmap

- Enable KeePassXC secret service integration
  - https://avaldes.co/2020/01/28/secret-service-keepassxc.html
  - https://wiki.chucknemeth.com/linux/security/keyring/keepassxc-keyring
- Install and set up Intellij
  - Ideavimrc
  - https://github.com/MarcoIeni/intellimacs
- Set up Syncthing
- Set up Homelab VPN client endpoint

