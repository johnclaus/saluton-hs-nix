# This file contains the bash history (edited for clarity) of the interactive
# session(s) during which this repository was created. It has been heavily
# annotated and is provided as an aid in understanding the origins of and
# dependencies between files in the repository.

echo "Don't run this file, read it!"
return # This file is not meant to be run!

# STARTING THE PROJECT

mkdir saluton-hs-nix
cd saluton-hs-nix
# Create a new project directory

mkdir saluton
git init
# saluton/ will contain our Haskell code and project build instructions, and
# the top-level (saluton-hs-nix) will contain our deployment specific nix
# expressions. Everything ends up in version control, but the deployment
# specification is kept separate from the code to keep things neat.

mkdir saluton/src
vim saluton/src/Main.hs
vim saluton/saluton.cabal
# Add some actual Haskell source code to the project, then 

# BUILDING VIA NIX

nix-env --install cabal2nix
# cabal2nix is an extremely useful utility that parses cabal files to
# automatically create nix build expressions for you.

cd saluton
cabal2nix . >saluton.nix
cd -
# Note that when packaging a local project, cabal2nix takes a project directory
# containing a cabal file, not the cabal file itself.
# Note also that current versions of cabal2nix seem to have a directory
# resolution bug, so if you get an error like
# "/home/rowanblush/saluton-hs-nix/saluton/saluton no such file or directory",
# make sure you generated the nix expression from the same directory the cabal
# file is located in.
# saluton/saluton.nix contains a nix function that when fully applied
# replicates the specification of the build environment implied in
# saluton/saluton.cabal . 

vim saluton/default.nix
# A relatively boilerplate nix expression that calls saluton/saluton.nix with
# the packages necessary to build the Haskell source code. This file implicitly
# specifies the versions of packages that will be used to build your project by
# importing nixpkgs by default.

echo "result/" >.gitignore
# Tell git to ignore nix build results directory so we don't commit binaries
# and build artifacts.

NIXPKGS_ALLOW_UNFREE=1 nix-build saluton/
# Use nix-build (installed with the nix package manager itself) to build the
# Haskell project.
# Because this example is meant to demonstrate building applications that are
# presumably unfree (e.g., closed source apps), we add a variable to the bash
# environment to allow nix to build unfree packages in just this case. If your
# package has a free software license this is unnecessary, or if you don't care
# about installing unfree software on your system you can set
# `nixpkgs.config.allowUnfree = true;` in your nixos configuration.nix or
# `allowUnfree = true;` in ~/.nixpkgs/config.nix .
# The results of the build if successful will be added to the nix-store and
# symlinked to results/ in the local directory.

sudo ./result/bin/saluton
# Because this project is configured to listen on port 80, it is run as root.

#$ curl localhost
#Saluton, mondo!

^C
# From a second terminal, we check that the app is responding correctly, then
# kill the process with SIGINT (Control-C).

# SETTING UP AND USING NIXOPS

nix-env --install nixops
# Make sure nixops is installed.

cd
vim rootkey.csv.txt # AWS Access Key ID and Secret Access Key (downloaded from AWS)
mv rootkey.csv.txt .ec2-keys # Formatted for nixops: KeyID Key Shortname
cd -
# After downloading an AWS secret access key (accomplished via browser out of
# band), move back to the home directory to format it correctly for nixops,
# change the name so that nixops can find it, and return to saluton-hs-nix/ .

vim saluton-configuration.nix
vim saluton-ec2.nix
# Define the logical and physical machine nix expressions used to host the app.

nixops create saluton-configuration.nix saluton-ec2.nix -d saluton
# Create the initial nixops configuration for the project.
# If you change your source code or network configuration, update nixops with
#nixops modify saluton-configuration.inx saluton-ec2.nix -d saluton

NIXPKGS_ALLOW_UNFREE=1 nixops deploy -d saluton
# Deploy the application to ec2.
# After updating the deployment configuration with `nixops modify`, run this
# command again to redeploy.

nixops info -d saluton
# This command provides info on all resources specified in the deployment. Take
# note of the IP address in the right-most column.

#$ curl [ipaddress]
#Saluton, mondo!

# Et, voila!
