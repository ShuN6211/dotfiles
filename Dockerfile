FROM --platform=linux/amd64 nixos/nix:latest

RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf && \
    echo "sandbox = false" >> /etc/nix/nix.conf

WORKDIR /home/shun/workspace/dotfiles
COPY . .

# Nix flakes require files to be tracked by git
RUN git init && git add -A

RUN nix build .#homeConfigurations.shun-linux.activationPackage --no-link --option sandbox false --option filter-syscalls false
