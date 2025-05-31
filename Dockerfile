FROM debian

RUN apt update && apt install -y emacs-nox


# https://github.com/drduh/YubiKey-Guide#install-software
RUN apt -y install \
    wget gnupg2 gnupg-agent dirmngr \
    cryptsetup scdaemon pcscd \
    yubikey-personalization yubikey-manager



