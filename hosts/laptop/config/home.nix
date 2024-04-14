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

    programs.home-manager.enable = true;


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
#     qt5ct                                                  # qt5 configuration tool
#     qt6ct                                                  # qt6 configuration tool
# --------------------------------------------------- // Applications
      ark
      bat
      bottom
      broot
      btop
      cargo
      cava
      calcure
      calcurse
      cbonsai
      cmatrix
      cifs-utils
      cbonsai
      celluloid
      dolphin
      dunst # notification daemon
      du-dust
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
      freerdp
      freetype
      fuse-common
      fzf
      hyprpaper
      hyprland
      imv
      gammastep
      gcc
      git
      glow
      gnome.gnome-keyring
      gnugrep
      gnumake
      gparted
      grim
      grub2
      jellyfin-mpv-shim
      jellyfin-media-player
      kitty
      krabby
      lazycli
      libverto
      lsd
      luarocks
      mako
      mailspring
      mangal
      macchina
      mangohud
      mediainfo
      micro
      mpd
      mpv
      nap
      navi
      neovim
      neofetch
      nfs-utils
      ninja
      nodejs
      oh-my-zsh
      openssl
      obsidian
      os-prober
      nerdfonts
      pandoc
      pass
      pavucontrol
      playerctl
      ncmpcpp
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
      the-way
      trashy
      tmux
      terminus-nerdfont
      tldr
      unzip
      waybar                                                 # system bar
      wezterm
      wget
      wiki-tui
      wl-clipboard
      vim
      vscode
      wofi
      xclip
      xfce.thunar
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xpipe
      yai
      yazi
      yt-dlp
      youtube-tui
      zoxide
      zip
      ueberzugpp
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
