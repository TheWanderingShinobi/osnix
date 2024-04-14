{ config, lib, pkgs, ... }:
{
  home.file.".config/wlogout" = {
    recursive = true;
    source = ./config/wlogout;
  };
}
