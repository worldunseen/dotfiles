# worldunseen's dotfiles

Automatically configures all my settings using Ansible.

## TL;DR

```
./setup.sh
```

## Support

The only operating system that is currently supported is the standard Fedora Workstation desktop (with GNOME). Tested on a Lenovo ThinkPad T14 Gen 4 (Intel) running Fedora 39.

## Highlights

- Strives to maintain vanilla GNOME behavior, including using default applications
- Separate profiles (`worldunseen`, `personal`, etc.) that run depending on current account username
- Out-of-the-box video codec and hardware acceleration support
- Only imports new repositories (Flathub, RPM Fusion, etc.) if required for installing applications
- Minimal manual intervention, if it can be automated by Ansible it will

## Future roadmap

- Set up GPG keys and enable signing commits automatically if present
- Enable KeePassXC secret service integration
  - https://avaldes.co/2020/01/28/secret-service-keepassxc.html
  - https://wiki.chucknemeth.com/linux/security/keyring/keepassxc-keyring
- Install and set up Intellij
  - Ideavimrc
  - https://github.com/MarcoIeni/intellimacs
- Set up Syncthing
- Set up Homelab VPN client endpoint

