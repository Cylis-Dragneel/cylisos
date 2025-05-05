{
  pkgs,
  ...
}:
{
  programs.starship =
    let
      macchiatoPreset = import ./macchiato.nix { inherit pkgs; };
      rosePinePreset = import ./rosePine.nix { inherit pkgs; };
      tokyoPreset = import ./tokyo.nix { inherit pkgs; };
    in
    {
      enable = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
      settings = rosePinePreset;
      enableTransience = true;
    };
}
