{
  pkgs,
  host,
  username,
  ...
}:
{
  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions =
          with pkgs.vscode-extensions;
          [
            ms-python.python
            ms-python.pylint
            catppuccin.catppuccin-vsc
            catppuccin.catppuccin-vsc-icons
            # johnpapa.peacock
            github.copilot
            github.copilot-chat
            ritwickdey.liveserver
            # ms-azuretools.vscode-docker
            # prettier.prettier
            # gitkraken.gitlens
            # junhan.code-runner
            # microsoft.remote-ssh
            # jeff-hykin.polacode
            mechatroner.rainbow-csv
            vscodevim.vim
            golang.go
            eamodio.gitlens
            esbenp.prettier-vscode
            jnoortheen.nix-ide
            arrterian.nix-env-selector
            mkhl.direnv
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "errorlens";
              publisher = "usernamehw";
              version = "3.24.0";
              sha256 = "sha256-Y3M/A5rYLkxQPRIZ0BUjhlkvixDae+wIRUsBn4tREFw=";
            }
            {
              name = "vscode-wakatime";
              publisher = "wakatime";
              version = "25.0.0";
              sha256 = "sha256-n/7y2nbD+ziUCDmNbfuT01GK/ls8rTfghpntj6SmsbA=";
            }
            {
              name = "ripgrep";
              publisher = "jimmyzjx";
              version = "0.4.2";
              sha256 = "sha256-ZP7taq/37rJhbiwD0Vk+6YM6+smjUhC93BFKxcmneMM=";
            }
          ];
        userSettings = {
          "update.mode" = "none";
          "extensions.autoUpdate" = false; # Disable extension auto-updates
          "extensions.autoCheckUpdates" = false; # Disable checking for extension updates

          "editor.cursorBlinking" = "smooth";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.wordWrap" = "on";
          "editor.formatOnSave" = true;
          "editor.minimap.enabled" = false;
          "editor.fontFamily" = "Maple Mono NF CN Medium";
          "editor.suggestFontSize" = 13;
          "editor.fontSize" = 13;
          "editor.suggestLineHeight" = 30;
          "editor.fontWeight" = "400";
          "codesnap.backgroundColor" = "#FFC540";
          "codesnap.showLineNumbers" = false;
          "codesnap.roundedCorners" = true;
          "editor.fontLigatures" = "'calt','cv01','cv02','cv03','cv31','ss03'";
          "editor.lightbulb.enabled" = "off";

          "workbench.colorTheme" = "Catppuccin Macchiato";
          "workbench.iconTheme" = "catppuccin-macchiato";
          "workbench.activityBar.location" = "hidden";
          # "workbench.statusBar.visible" = false;
          "workbench.sideBar.location" = "right";
          "window.menuBarVisibility" = "compact";

          "terminal.integrated.fontFamily" = "Maple Mono";
          "terminal.integrated.lineHeight" = 1.5;
          "terminal.integrated.fontSize" = 13;

          "search.useIgnoreFiles" = false;
          "search.exclude" = {
            "**/.direnv/" = true;
            "**/node_modules" = true;
            "**/dist" = true;
          };

          "ripgrep.exe" = "${pkgs.ripgrep}/bin/ripgrep";

          "nix.serverPath" = "nixd";
          "nix.serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = [ "nixfmt" ];
              };
              "autowatch" = true;
              "nixpkgs" = {
                "expr" = "import (builtins.getFlake '/home/${username}/cylisos').inputs.nixpkgs { }";
              };
              "options" = {
                "nixos" = {
                  "expr" = "(builtins.getFlake '/home/${username}/cylisos').nixosConfigurations.${host}.options";
                };
                "home-manager" = {
                  "expr" = "(builtins.getFlake '/home/${username}/cylisos').homeConfigurations.${username}.options";
                };
              };
            };
          };

          "vim.insertModeKeyBindings" = [
            {
              before = [
                "j"
                "k"
              ];
              after = [ "<Esc>" ];
            }
          ];

          # Go specific update disabling
          "go.gopath" = "";
          "go.toolsManagement.checkForUpdates" = "off";
          # Go settings
          "go.useLanguageServer" = true;
          "go.toolsManagement.autoUpdate" = false;
          "go.formatTool" = "goimports";
          "go.lintTool" = "golint";
          "go.testOnSave" = false;

          # Correctly formatted Go settings for Nix
          "[go]" = {
            "editor.insertSpaces" = false;
            "editor.formatOnSave" = true;
            "editor.codeActionsOnSave" = {
              "source.organizeImports" = "always";
            };
          };

          # Go language server settings
          "gopls" = {
            "usePlaceholders" = true;
            "staticcheck" = true;
            "completeUnimported" = true;
            "matcher" = "Fuzzy";
            "analyses" = {
              "nilness" = true;
              "unusedparams" = true;
              "unusedwrite" = true;
              "useany" = true;
            };
          };

          # Debugging
          "go.delveConfig" = {
            "dlvLoadConfig" = {
              "followPointers" = true;
              "maxVariableRecurse" = 1;
              "maxStringLen" = 128;
              "maxArrayValues" = 64;
              "maxStructFields" = -1;
            };
            "apiVersion" = 2;
            "showGlobalVariables" = false;
          };

          "[javascript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };

          # Direnv settings
          "direnv.enable" = true;
          "nix.enableLanguageServer" = true;
        };
        keybindings = [
          {
            key = "ctrl+shift+f";
            command = "ripgrep.find";
          }
        ];
      };
    };
  };
}
