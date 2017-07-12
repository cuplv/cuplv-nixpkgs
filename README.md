# CUPLV Nix package overlay #

These are packages for
the [Nix package manager](http://nixos.org/nix/).

## Installation ##

To use these packages, clone the repository and create a symbolic link
to it in the `nixpkgs` overlays directory.

    cd $HOME
    git clone https://github.com/cuplv/cuplv-nixpkgs
    mkdir -p $HOME/.config/nixpkgs/overlays
    ln -sT $HOME/cuplv-nixpkgs $HOME/.config/nixpkgs/overlays

You can then hack on or update your cloned copy of `cuplv-nixpkgs` and
any changes will take effect in the next `nix-build` or `nix-shell`
invocation.
