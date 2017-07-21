# CUPLV Nix package overlay #

These are packages for
the [Nix package manager](http://nixos.org/nix/).

## Installation ##

To use these packages, clone the repository and create a symbolic link
to it in the `nixpkgs` overlays directory using the `install` script.

    git clone https://github.com/cuplv/cuplv-nixpkgs
    cd cuplv-nixpkgs
    ./install

You can then hack on or update your cloned copy of `cuplv-nixpkgs` and
any changes will take effect in the next `nix-build` or `nix-shell`
invocation.

This installation can be undone by removing the symlink.

    rm -v $HOME/.config/nixpkgs/overlays/cuplv-nixpkgs
