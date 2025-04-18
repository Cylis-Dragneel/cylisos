{ pkgs }:
let
  flavour = "macchiato";
in
{
  scan_timeout = 30;
  add_newline = false;
  format = "$all";
  palette = "catppuccin_${flavour}";
  direnv = {
    format = "[$symbol$loaded$/$allowed]($style)";
    symbol = "direnv ";
    style = "bold orange";
  };
  username = {
    show_always = true;
    format = "[ $user]($style) ";
    style = "bold bg:none fg:#7aa2f7";
  };
  time = {
    use_12hr = false;
    time_range = "-";
    time_format = "%R";
    utc_time_offset = "local";
    format = "[ $time 󰥔]($style) ";
    style = "bold #393939";
  };
}
// builtins.fromTOML (
  builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "HEAD";
      sha256 = "sha256-t/Hmd2dzBn0AbLUlbL8CBt19/we8spY5nMP0Z+VPMXA=";
    }
    + /themes/${flavour}.toml
  )
)
