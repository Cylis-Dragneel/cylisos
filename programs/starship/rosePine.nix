{ pkgs }:
let
  flavour = "moon";
in
{
  add_newline = false;
  palette = "rose-pine-${flavour}";
  palettes = {
    rose-pine-moon = {
      overlay = "#393552";
      love = "#eb6f92";
      gold = "#f6c177";
      rose = "#ea9a97";
      pine = "#3e8fb0";
      foam = "#9ccfd8";
      iris = "#c4a7e7";
    };
  };
  format = "$directory$git_branch$git_commit\n$character";
  character = {
    success_symbol = "[](bold foam)";
    error_symbol = "[](love) ";
    vicmd_symbol = "[](iris)";
    # format = "$symbol[ ](bold base5 ";
    # format = "$symbol[λ ](bold base5) ";
    format = "$symbol[❯](bold pine) ";
  };
  right_format = "$all";
  command_timeout = 2000;
  scan_timeout = 100;
  git_branch = {
    format = "[](fg:overlay)[ $symbol $branch ]($style)[](fg:overlay) ";
    style = "bg:overlay fg:foam";
    symbol = "";
  };
  # git_branch = {
  #   format = "on [$symbol$branch(:$remote_branch)]($style) ";
  #   symbol = " ";
  #   style = "bold purple";
  # };
  git_commit = {
    format = "[\($hash$tag\)]($style) ";
    commit_hash_length = 7;
    style = "bold green";
  };
  # golang = {
  #   format = "via [$symbol($version )]($style)";
  #   style = "bold blue";
  #   symbol = "[ ]($style)";
  # };
  lua = {
    format = "via [$symbol($version )]($style)";
    symbol = "[]($style) ";
    style = "bold blue";
  };
  nix_shell = {
    symbol = " ";
    format = "via [$symbol$state]($style) ";
    # symbol = "󱄅 ";
    # format = "via [$symbol$state( \($name\))]($style) ";
    style = "bold blue";
    disabled = false;
  };
  # nodejs = {
  #   format = "via [$symbol($version )]($style)";
  #   style = "bold green";
  #   symbol = " ";
  #   version_format = "v$raw(blue)";
  # };
  ocaml = {
    format = "via [$symbol($version )(\($switch_indicator$switch_name\) )]($style)";
    symbol = "🐫 ";
    style = "bold yellow";
    version_format = "v$raw";
  };
  package = {
    format = "is [$symbol$version]($style) ";
    symbol = " ";
    style = "bold 208";
  };
  # python = {
  #   format = "via [$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)";
  #   symbol = "[]($style) ";
  #   style = "bold yellow";
  # };

  # rust = {
  #   format = "via [$symbol($version )]($style)";
  #   symbol = "[]($style) ";
  #   style = "bold red";
  # };
  zig = {
    format = "via [$symbol($version )]($style)";
    symbol = "[ ]($style)";
    style = "bold yellow";
  };
  # username = {
  #   show_always = false;
  #   format = "[ $user]($style) ";
  #   style_user = "bold bg:none fg:cyan";
  # };
  # time = {
  #   use_12hr = false;
  #   time_range = "-";
  #   time_format = "%T";
  #   utc_time_offset = "local";
  #   format = "[ $time 󰥔]($style) ";
  #   style = "bold base3";
  # };
  # c = {
  #   symbol = " ";
  # };
  # nim = {
  #   symbol = "󰆥 ";
  # };
  # julia.symbol = " ";
  php.symbol = " ";
  ruby.symbol = " ";
  directory = {
    format = "[](fg:overlay)[ $path ]($style)[](fg:overlay) ";
    style = "bg:overlay fg:pine";
    read_only = " 󰌾";
    truncation_length = 3;
    truncation_symbol = "./";
    substitutions = {
      Documents = "󰈙";
      Downloads = " ";
      Music = " ";
      Pictures = " ";
    };
  };

  fill = {
    style = "fg:overlay";
    symbol = " ";
  };

  git_status = {
    disabled = false;
    style = "bg:overlay fg:love";
    format = "[](fg:overlay)([ $all_status$ahead_behind ]($style))[](fg:overlay) ";
    up_to_date = "[ ✓ ](bg:overlay fg:iris)";
    untracked = "[?($count)](bg:overlay fg:gold)";
    stashed = "[$$](bg:overlay fg:iris)"; # Escaped literal $
    modified = "[!($count)](bg:overlay fg:gold)";
    renamed = "[»($count)](bg:overlay fg:iris)";
    deleted = "[✘($count)]($style)";
    staged = "[++($count)](bg:overlay fg:gold)";
    ahead = "[⇡$count](bg:overlay fg:foam)";
    diverged = "⇕[\[](bg:overlay fg:iris)[⇡$ahead_count](bg:overlay fg:foam)[⇣$behind_count](bg:overlay fg:rose)[\]](bg:overlay fg:iris)";
    behind = "[⇣$count](bg:overlay fg:rose)";
  };

  time = {
    disabled = true;
    format = " [](fg:overlay)[ $time 󰴈 ]($style)[](fg:overlay)";
    style = "bg:overlay fg:rose";
    time_format = "%H:%M";
    use_12hr = false;
  };

  username = {
    disabled = false;
    format = "[](fg:overlay)[ 󰧱 $user ]($style)[](fg:overlay) ";
    show_always = true;
    style_root = "bg:overlay fg:iris";
    style_user = "bg:overlay fg:iris";
  };

  # Languages
  c = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = " ";
  };

  elixir = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = " ";
  };

  elm = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = " ";
  };

  golang = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ](style)[](fg:overlay)";
    disabled = false;
    symbol = " ";
  };

  haskell = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = " ";
  };

  java = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = " ";
  };

  julia = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = " ";
  };

  nodejs = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = "󰎙 ";
  };

  nim = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = "󰆥 ";
  };

  rust = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = " ";
  };

  scala = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = " ";
  };

  python = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
    disabled = false;
    symbol = " ";
  };

  conda = {
    style = "bg:overlay fg:pine";
    format = " [](fg:overlay)[ $symbol$environment ]($style)[](fg:overlay)";
    disabled = false;
    symbol = "🅒 ";
  };
}
