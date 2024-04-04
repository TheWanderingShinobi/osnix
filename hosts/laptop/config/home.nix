{pkgs, config, inputs, ...}: let
  username = "keeper";
in {
  imports = [
    ./packages
  ];

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";

  #programs.home-manager.enable = true;


    packages = with pkgs; [
     bluez                                                  # bluetooth protocol stack
     blueman                                                # bluetooth manager gui
     brightnessctl                                          # screen brightness control
# --------------------------------------------------- // Display Manager
     sddm
# --------------------------------------------------- // Window Manager
     swww                                                   # wallpaper
     swaylock-effects                                   # lock screen
     wlogout                                                # logout menu
     grimblast                                          # screenshot tool
     hyprpicker                                             # color picker
     slurp                                                  # region select for screenshot/screenshare
     swappy                                                 # screenshot editor
     cliphist                                               # clipboard manager
# --------------------------------------------------- // Dependencies
     polkit-kde-agent                                       # authentication agent
     parallel                                               # for parallel processing
     jq                                                     # for json processing
     imagemagick                                            # for image processing
# --------------------------------------------------- // Theming
     nwg-look                                               # gtk configuration tool
     qt5ct                                                  # qt5 configuration tool
     qt6ct                                                  # qt6 configuration tool
# --------------------------------------------------- // Applications
      wofi
      gammastep
      libsForQt5.okular
      pandoc
      ark
      bat
      broot
      btop
      cargo
      cava
      cbonsai
      cmatrix
      cbonsai
      celluloid
      dolphin
      dunst                                               # notification daemon
      efibootmgr
      espanso
      eza
      feh
      fd
      flameshot
      flatpak
      floorp
      fontconfig
      firefox
      fish
      freetype
      fuse-common
      fzf
      hyprland
      gcc
      git
      glow
      gnome.gnome-keyring
      gnugrep
      gnumake
      gparted
      gnugrep
      grim
      grub2
      kitty
      krabby
      libverto
      lsd
      luarocks
      lxappearance
      mako
      mangal
      mangohud
      mpd
      mpv
      navi
      neovim
      neofetch
      nfs-utils
      ninja
      nodejs
      nomacs
      oh-my-zsh
      openssl
      obsidian
      os-prober
      nerdfonts
      pass
      pavucontrol
      polkit_gnome
      protonup-ng
      python3Full
      python.pkgs.pip
      ranger
      ripgrep
      ripgrep-all
     # rofi
      rsclock
      sd
      slurp
      starship
      steam
      steam-run
      swappy
      swaycons
      swayidle
      sway-audio-idle-inhibit
      tailscale
      tmux
      terminus-nerdfont
      tldr
      trash-cli
      unzip
      waybar                                                 # system bar
      wezterm
      wget
      wiki-tui
      wl-clipboard
      vim
      vscode
      xclip
      xfce.thunar
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      yai
      yazi
      yt-dlp
      zoxide
      zip
      unzip
      zsh 
      zsh-powerlevel10k

      (lutris.override {
        extraPkgs = pkgs: [
          # List package dependencies here
          wineWowPackages.stable
          winetricks
        ];
      })
    ];
  };
}
