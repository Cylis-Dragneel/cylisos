{ pkgs, ... }:

pkgs.writeShellScriptBin "import-cursor" ''
  set -e

  if [ $# -ne 2 ]; then
    echo "Usage: $0 <zip-file> <name>"
    exit 1
  fi

  ZIP_FILE="$1"
  NAME="$2"
  NAME_LOWER="''${NAME,,}"
  EXTRACT_DIR="$(pwd)/$NAME_LOWER"
  TEMPLATE_NIX="$HOME/cylisos/modules/zani-cursor.nix"
  TARGET_NIX="$HOME/cylisos/modules/''${NAME_LOWER}-cursor.nix"

  if [ ! -f "$ZIP_FILE" ]; then
    echo "Error: Zip file not found: $ZIP_FILE"
    exit 1
  fi

  if [ ! -f "$TEMPLATE_NIX" ]; then
    echo "Error: Template nix file not found: $TEMPLATE_NIX"
    exit 1
  fi

  mkdir -p "$EXTRACT_DIR"
  unzip -o "$ZIP_FILE" -d "$EXTRACT_DIR"

  cd "$EXTRACT_DIR"
  mkdir -p cursors
  ${pkgs.win2xcur}/bin/win2xcur **/*.ani -o cursors
  rm -rf Cursors Gifs MacOS Static ENG.pdf RUS.pdf source.url

  sed "s/zani/$NAME_LOWER/g; s/Zani/$NAME/g" "$TEMPLATE_NIX" > "$TARGET_NIX"

  echo "Done! Cursor theme installed to: $EXTRACT_DIR"
  echo "Nix config created at: $TARGET_NIX"
''
