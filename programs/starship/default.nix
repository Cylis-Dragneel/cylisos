{
  pkgs,
  ...
}:
{
  programs.starship =
    let
      macchiatoPreset = import ./macchiato.nix { inherit pkgs; };
      premiumPreset = import ./premium.nix { inherit pkgs; };
    in
    {
      enable = true;
      enableNushellIntegration = true;
      settings = premiumPreset;
      enableTransience = true;
    };
}
