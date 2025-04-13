{
  pkgs,
  host,
  username,
  ...
}:
{
  enable = true;
  autosuggestion.enable = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;
  shellAliases = {
    sv = "sudo nvim";
    # fr = "nh os switch --hostname ${host} /home/${username}/cylisos";
    # fu = "nh os switch --hostname ${host} --update /home/${username}/cylisos";
    # hms = "nh home switch /home/${username}/cylisos/";
    fr = "nh os switch";
    fu = "nh os switch --update";
    hms = "nh home switch";
    ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
    v = "nvim";
    ls = "eza --icons";
    ll = "eza -lh --icons --grid --group-directories-first";
    la = "eza -lah --icons --grid --group-directories-first";
    host = "nvim ~/cylisos/hosts/${host}/";
    config = "nvim ~/cylisos/config/";
    py-server = "python -m http.server 8040";
    rl = "source ~/.zshrc";
    cmc = "cmus-remote -C 'clear'";
    cma = "cmus-remote -C 'add ~/Music";
    cmu = "cmus-remote -C 'update-cache -f'";
    nix-shell = "nix-shell --command zsh";
    nix-develop = "nix develop --command zsh";
    ytmd = "yt-dlp --embed-metadata -x $(ytfzf -I l | grep 'https://')";
    spotd = "spotdl download $1";
    oo = "cd /home/${username}/Documents/Main/";
    orv = "nvim '/home/${username}/Documents/Main/01 - Rough Notes/'*";
    lz = "lazygit";
    emd = "emacs --daemon";
    emc = "emacsclient -c .";
    zed = "zeditor --foreground ./";
    pod-up = "podman-compose up -d";
    pod-down = "podman-compose down";
  };
  defaultKeymap = "viins";
  history = {
    ignoreAllDups = true;
    path = "$HOME/.zsh_history";
    save = 10000;
    size = 10000;
  };
  profileExtra = ''
    # if [ -z "$DISPLAY" ]; then
    #  exec awesome
    # fi
  '';
  initExtra = ''
    bindkey -v
    bindkey '^F' autosuggest-accept
    export KEYTIMEOUT=1
    nitch

    # [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
    # OMP
    # eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/dracula.omp.json)"
    zstyle ':completion:*:git-checkout:*' sort false
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' list-colours ''${(s.:.)LS_COLORS}
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    _comp_options+=(globdots)
    eval "$(fzf --zsh)"
    eval $(thefuck --alias tf)
    export MANPAGER='nvim +Man!'
    mpv-script() {
      local script_name="$1"
      if [[ -z "$script_name" ]]; then
        echo "Usage: mpv-script <script-name>"
        return 1
      fi
      echo '{"command":["script-message", "'"$script_name"'"] }' | socat - /tmp/mpvsocket
    }
    mpv-append() {
      local vid="$1"
      if [[ -z "$vid" ]]; then
        echo "Usage: mpv-append <video-url>"
        return 1
      fi
      echo '{"command": ["loadfile", "'"$vid"'", "append-play"]}' | socat - /tmp/mpvsocket
    }

    function zle-keymap-select {
      if [[ "$KEYMAP" == vicmd ]] ||
         [[ $1 = "block" ]]; then
        echo -ne "\e[1 q"
      elif [[ "$KEYMAP" == main ]] ||
           [[ "$KEYMAP" == viins ]] ||
           [[ "$KEYMAP" = "" ]] ||
           [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
      fi
    }
    zle -N zle-keymap-select
    zle-line-init() {
        zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
        echo -ne "\e[5 q"
    }
    zle -N zle-line-init
    echo -ne '\e[5 q' # Use beam shape cursor on startup.
    preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
  '';
  oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "sudo"
      "golang"
      "rust"
      "command-not-found"
      "pass"
      "direnv"
    ];
  };
  plugins = [
    {
      name = "zsh-autosuggestions";
      src = pkgs.zsh-autosuggestions;
      file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
    }
    {
      name = "zsh-completions";
      src = pkgs.zsh-completions;
      file = "share/zsh-completions/zsh-completions.zsh";
    }
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.zsh-syntax-highlighting;
      file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
    }
    # {
    #   name = "powerlevel10k";
    #   src = pkgs.zsh-powerlevel10k;
    #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    # }
    {
      name = "fzf-tab";
      src = pkgs.zsh-fzf-tab;
      file = "share/fzf-tab/fzf-tab.plugin.zsh";
    }
  ];
}
