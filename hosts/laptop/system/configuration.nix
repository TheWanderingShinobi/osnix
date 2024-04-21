# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# Bootloader.

 boot = {
    kernelParams = ["nohibernate"];
    tmp.cleanOnBoot = true;
    supportedFilesystems = ["ntfs"];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        device = "nodev";
        efiSupport = true;
        enable = true;
        useOSProber = true;
        timeoutStyle = "menu";
      };
      timeout = 300;
    };

    kernelModules = ["tcp_bbr"];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq";
      "net.core.wmem_max" = 1073741824;
      "net.core.rmem_max" = 1073741824;
      "net.ipv4.tcp_rmem" = "4096 87380 1073741824";
      "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
    };
  };

  # Better scheduling for CPU cycles - thanks System76!!!
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  # Enable TLP (better than gnomes internal power manager)
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  # Disable GNOMEs power management
  services.power-profiles-daemon.enable = false;

  # Enable powertop
  powerManagement.powertop.enable = true;

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

# Enable networking
  networking = {
    hostName = "osnix";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall.enable = false;
  };

 # Package mangement
   nix = {
     gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
  };
     settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
   };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (builtins.parseDrvName pkg.name).name ["steam"]; 
      permittedInsecurePackages = [
          "openssl-1.1.1v"
          "python-2.7.18.7"
      ];
    };
  };
  
  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

 # Enable the X11 windowing system.
 
 services.xserver = {
    enable = true;

    displayManager.sddm.sugarCandyNix = {
      enable = true; # This enables SDDM automatically and set its theme to
                     # "sddm-sugar-candy-nix"
      settings = {
        # Set your configuration options here.
        # Here is a simple example:
        Background = lib.cleanSource ~/osnix/hosts/laptop/config/nixos-wallpapers.png;
        ScreenWidth = 1920;
        ScreenHeight = 1080;
        FormPosition = "center";
        HaveFormBackground = true;
        PartialBlur = true;
        # ...
      };
    };
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
   pulse.enable = true;
  };

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.keeper = {
    isNormalUser = true;
    description = "keeper";
    extraGroups = [
      "flatpak"
      "disk"
      "qemu"
      "kvm"
      "libvirtd"
      "sshd"
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "libvirtd"
      "root"
    ];    
    packages = with pkgs; [
      firefox
     ];
  };

 # Default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];
  security.pam.services.swaylock = {};



  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget
     kitty
     neovim
     distrobox
     podman-compose
     podman-tui
     libsForQt5.dolphin
     libsForQt5.ark
     libsForQt5.gwenview
     libsForQt5.dolphin-plugins
     libsForQt5.ffmpegthumbs
     libsForQt5.kdegraphics-thumbnailers
     libsForQt5.kio
     libsForQt5.kio-extras
     libsForQt5.qtwayland
     libsForQt5.okular
     
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

# Virtualisation
 # Enable Podman
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };




  # List services that you want to enable:

  services.openssh.enable = true;
  services.gvfs.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.tailscale.enable = true;
  services.dbus.enable = true;
  services.flatpak.enable = true;

# Programs
 programs.hyprland.enable = true;
 programs.hyprland.xwayland.enable = true;

  security.pam.services.swaylock = {};
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

 programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

   security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

    system.stateVersion = "23.11";
}
