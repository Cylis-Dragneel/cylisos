{
  lib,
  appimageTools,
  fetchurl,
}:

let
  pname = "anymex";
  version = "3.0.4";

  src = fetchurl {
    url = "https://github.com/RyanYuuki/AnymeX/releases/download/v${version}/AnymeX-Linux.AppImage";
    hash = "sha256-rQLEHv4Gw5pBAthFfS6lVrQnnm5yhE3ISOUNs16OCLU=";
    # ^ This is the sha256 from the release. Convert from hex:
    # nix hash convert --hash-algo sha256 --to sri ad02c41efe06c39a4102d8457d2ea556b4279e6e72844dc848e50db35e8e08b5
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs =
    pkgs: with pkgs; [
      webkitgtk_4_1
      libsoup_3
      mpv
      libepoxy
    ];

  extraInstallCommands = ''
    # Install desktop entry if it exists
    install -m 444 -D ${appimageContents}/anymex.desktop \
      $out/share/applications/anymex.desktop 2>/dev/null || true

    # Install icon
    for size in 16 32 48 64 128 256 512; do
      icon="${appimageContents}/usr/share/icons/hicolor/''${size}x''${size}/apps/anymex.png"
      if [ -f "$icon" ]; then
        install -m 444 -D "$icon" \
          $out/share/icons/hicolor/''${size}x''${size}/apps/anymex.png
      fi
    done

    # Fix Exec= in desktop file
    substituteInPlace $out/share/applications/anymex.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=anymex' 2>/dev/null || true
  '';

  meta = with lib; {
    description = "Open source multiservice anime/manga tracker (AniList, MAL, Simkl)";
    homepage = "https://github.com/RyanYuuki/AnymeX";
    downloadPage = "https://github.com/RyanYuuki/AnymeX/releases";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "anymex";
  };
}
