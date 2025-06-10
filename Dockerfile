FROM debian:bookworm

# From https://github.com/drduh/YubiKey-Guide#install-software
RUN apt-get update && apt-get -y install \
    wget gnupg2 gnupg-agent dirmngr \
    cryptsetup scdaemon pcscd \
    yubikey-personalization yubikey-manager

# Install the latest available emacs from backports: https://backports.debian.org/Instructions/
# At the moment of writing the org-mode in stable release is outdated and has a tiny annoying cosmetic defect.
# This is not strictly necessary though.
COPY debian-backports.sources /etc/apt/sources.list.d/
RUN apt-get update && apt-get install -y -t bookworm-backports emacs-nox

# Defaults. Override with --build-arg UID=$(id -u) --build-arg GID=$(id -g) to match your host system.
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID appuser && \
    useradd -u $UID \
        --gid $GID \
        --create-home \
        --no-log-init \
        appuser

# This is a good practice to run apps in docker not as a root, but as a user.
USER appuser
WORKDIR /home/appuser
ENV USER=appuser

COPY --chown=appuser:appuser init.el README.org /home/appuser/

# By default run emacs immediately, to skip the manual action of running it in shell.
CMD ["emacs", "--load", "init.el", "README.org"]

# Or, in case we run bash in this container, it would be convenient to quickly get this command from history.
RUN echo 'emacs --load init.el README.org' >> ~/.bash_history










# gpg --card-status only works for appuser in a podman container, not in a docker container for some reaspon.
# It works fine under root.
USER root
RUN apt-get install -y procps


