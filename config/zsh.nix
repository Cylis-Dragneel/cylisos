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
    fr = "nh os switch --hostname ${host} /home/${username}/cylisos";
    fu = "nh os switch --hostname ${host} --update /home/${username}/cylisos";
    hms = "nh home switch /home/${username}/cylisos/";
    ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
    v = "nvim";
    cat = "bat";
    ls = "eza --icons";
    ll = "eza -lh --icons --grid --group-directories-first";
    la = "eza -lah --icons --grid --group-directories-first";
    host = "nvim ~/cylisos/hosts/${host}/";
    config = "nvim ~/cylisos/config/";
    py-server = "python -m http.server 8040";
    py-virt = "source .venv/bin/activate";
    py-virtc = "python3 -m venv .venv";
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
  };
  defaultKeymap = "emacs";
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
    bindkey -e

    # [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
    krabby random
    # OMP
    # eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/dracula.omp.json)"
    zstyle ':completion:*:git-checkout:*' sort false
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' list-colours ''${(s.:.)LS_COLORS}
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
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
