{
  config,
  lib,
  pkgs,
  ...
}: {
  home.shellAliases = {

   # Utils
      c = "clear";
      cat = "bat";
      nano = "micro";
      code = "vscode";

      l = "eza --icons  -a --group-directories-first -1"; #EZA_ICON_SPACING=2
      ll = "eza --icons  -a --group-directories-first -1 --no-user --long";
      tree = "eza --icons --tree --group-directories-first";

      # Nixos
      cdnix = "cd ~/osnix && nvim ~/osnix";
      ns = "nix-shell --run zsh";
      nix-shell = "nix-shell --run zsh";
      nix-switch = "sudo nixos-rebuild switch --flake ~/osnix#laptop";
      nix-switchu = "sudo nixos-rebuild switch --upgrade --flake ~/osnix#laptop";
      nix-flake-update = "sudo nix flake update ~/osnix#";
      nix-clean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";
      # nix-clean = "sudo nix-collect-garbage -d";
      # nix-cleanold = "sudo nix-collect-garbage --delete-old";
      # nix-cleanboot = "sudo /run/current-system/bin/switch-to-configuration boot";

      # Git
      ga   = "git add";
      gaa  = "git add --all";
      gs   = "git status";
      gb   = "git branch";
      gm   = "git merge";
      gpl  = "git pull";
      gplo = "git pull origin";
      gps  = "git push";
      gpst = "git push --follow-tags";
      gpso = "git push origin";
      gc   = "git commit";
      gcm  = "git commit -m";
      gtag = "git tag -ma";
      gch  = "git checkout";
      gchb = "git checkout -b";
      gcoe = "git config user.email";
      gcon = "git config user.name";

      # g = "lazygit";

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";
 
    # rm alias
    rm = "rm -i";
    # clear
    clear = "clear -x";
    cls = "clear";
    # vim alias
    v = "nvim";
    # yazi alias
    y = "yazi";
    # tmux
    tnew = "tmux new -s";
    ta = "tmux attach -t";
    tdetach = "tmux detach";
    tkill = "tmux kill-session -t";
    tlist = "tmux ls";
    # bat
    bat = "bat --theme='Catppuccin-mocha'";
    # grep
    grep = "grep --color=auto";
    # python
    vimipython = "ipython --TerminalInteractiveShell.editing_mode=vi";
    # conda
    exportforge = "export PATH=$HOME/miniforge3/bin:$PATH";
    # network
    myip = "curl http://ipecho.net/plain; echo";
    # ncdu
    df = "df -ahiT --total";
    du = "ncdu --color dark -rr -x --exclude .git --exclude node_modules";
    # memory
    free = "free -mt";
    ps = "ps auxf";
    psgrep = "ps aux | grep -v grep | grep -i -e VSZ -e";

  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    history.extended = true;
    dirHashes = {
      dots = "$HOME/nixos-hyprland";
      docs = "$HOME/Documents";
      down = "$HOME/Downloads";
      nas = "$HOME/Frontdoor/";
      work = "$HOME/Documents/Work";
      personal = "$HOME/Documents/Personal";
    };
    initExtra = ''
      krabby random
      bindkey '^ ' autosuggest-accept
      export DIRENV_LOG_FORMAT=""
      export PATH="$PATH:$HOME/.cargo/bin"
    '';
    sessionVariables = {
      EDITOR = "nvim";
      TERM = "kitty";
      USE_EDITOR = "$EDITOR";
      VISUAL = "$EDITOR";
      BROWSER = "firefox";
      BAT_THEME = "Catppuccin-mocha";
    };
    # profileExtra = { };
    # shellAliases = { };
    # shellGlobalAliases = { };
    antidote = {
      enable = true;
      plugins = [
        "ohmyzsh/ohmyzsh path:lib/git.zsh"
        "ohmyzsh/ohmyzsh path:lib/clipboard.zsh"
        "ohmyzsh/ohmyzsh path:plugins/aliases"
        "ohmyzsh/ohmyzsh path:plugins/copypath"
        "ohmyzsh/ohmyzsh path:plugins/colored-man-pages"
        "ohmyzsh/ohmyzsh path:plugins/extract"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/git-extras"
        "ohmyzsh/ohmyzsh path:plugins/magic-enter"
        "ohmyzsh/ohmyzsh path:plugins/npm"
        "ohmyzsh/ohmyzsh path:plugins/pyenv"
        "ohmyzsh/ohmyzsh path:plugins/python"
        "ohmyzsh/ohmyzsh path:plugins/tmux"
        "djui/alias-tips"
        "dim-an/cod"
        "wfxr/forgit"
        "MichaelAquilina/zsh-autoswitch-virtualenv"
        "chisui/zsh-nix-shell"
        "nix-community/nix-zsh-completions"
      ];
    };
  };
}
