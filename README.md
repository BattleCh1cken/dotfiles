# Dotfiles

This repository contains the configuration for my NixOS installations.

> [!CAUTION]
> These files are for my use only. They are on my GitHub for ease of access, and for others to reference. Use at your own risk.

# Design Philosophy

My past NixOS configurations have been overly complex and badly documented. The main goal of this iteration is to address those issues. I should be able to easily change and maintain any part of the configuration, even if its a part of the config that I haven't looked at in a while.

## Config Files

This configuration attempts to keep all of its dotfiles (for example the configuration for the window managers) in separate, non-nix, files. This means that if I ever need to switch away from NixOS, I am capable of doing so without needing to transcribe them.

## Home manager

A lot of configs tend to have separate directories for standard NixOS modules and home-manager modules. This configuration puts all of these in the same folder.

# Project Documentation

## Architecture
