Saluton Haskell & Nix
=====================

Having often gotten lost in the documentation weeds while trying to get a
personal project ([Slowcial Club](http://slowcial.club)) written in Haskell up
and running on a NixOS instance on AWS using NixOps, this repository is
intended as a one-stop shop for documentation on exactly *how* all those oddly
shaped puzzle pieces fit together.

Nix beginners should start by installing [nix](http://nixos.org/nix), then
following along by reading commands.sh and opening each file in the repository
as it is referenced. Necessary utilities are installed along the way either
explicitly with nix-env or implicitly by beginning a build or deploy process.

Note that this repository is incomplete in that I have declined to provide my
own AWS credentials for you to experiment with. Before you can deploy the
example application to EC2, you must add your AWS secret key to ~/.ec2-keys for
nixops' use. Some information on this is provided in commands.sh, or refer to
the [Nixops Manual on Deploying to
EC2](http://nixos.org/nixops/manual/#sec-deploying-to-ec2).

Contributing
------------

Issues and pull requests gladly accepted, including (and especially!) for
documentation!

As Haskell & Nix are rather quickly moving targets, it's virtually certain that
version differences will trip you up somewhere. Please open an issue with
versions for nix (`nix-env --version`), nixos (`nixos-version`), nixops
(`nixops --version`), and current channel (both `sudo nix-channel --list` and
`nix-instantiate --eval --expr '(import <nixpkgs> {}).lib.nixpkgsVersion'`)
when you run into a brick wall.

Please add yourself to the AUTHORS file when making a pull request!

To-Do
-----

Want to contribute? Maybe start here!

* Add a VirtualBox physical machine specification.
* Demonstrate package overrides with config.nix . (I know Happstack doesn't
build at the moment with ghc784 on the nixos-unstable channel due to
reform-hsp not specifying a dependency on hsx2hs, this might be a good
example but I'm dancing around it because I want something timeless.)
* Expand to cover developing on NixOS, e.g. user environment, nix-shell, cabal
configure, &c.
* Update the NixOS Wiki! There's nothing here that couldn't be serialized to a
single page.

References
----------

A heaping helping of hearty thanks to the authors of all these materials for
their excellent documentation, in compiling this repository I have shamelessly
cribbed their workflows.

* The [cabal2nix User Guide](https://github.com/NixOs/cabal2nix/blob/master/doc/user-guide.md).
* [Development Environments](https://nixos.org/wiki/Development_Environments) on the NixOS Wiki.
* ocharles' [Nix wiki](http://wiki.ocharles.org.uk/Nix).
* The [NixOS](http://nixos.org/nixos/manual) and [NixOps](http://nixos.org/nixops/manual) manuals.
* A lot more knowledge that I osmosed while frantically Googling and have since
closed the tab on.

---

Saluton is a common greeting in Esperanto.
