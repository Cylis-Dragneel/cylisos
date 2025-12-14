{
  pkgs,
  inputs,
  ...
}:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      prettier
      lldb
      delve
      just-formatter
      just-lsp
    ];
    languages = {
      language-server = {
        wakatime.command = "${
          inputs.wakatime-ls.packages.${pkgs.stdenv.hostPlatform.system}.default
        }/bin/wakatime-ls";
        rust-analyzer.config = {
          checkOnSave.command = "clippy";
          cargo.allFeatures = true;
        };
        clangd = {
          command = "clangd";
          args = [
            "--background-index"
            "--clang-tidy"
            "--header-insertion=iwyu"
          ];
        };
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
          args = [
            "--semantic-tokens=true"
            "--inlay-hints=true"
          ];
        };
        tailwindcss = {
          command = "tailwindcss-language-server";
          args = [ "--stdio" ];
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = [ "class: \"(.*)\"" ];
              };
            };
          };
        };
        typescript-language-server = {
          command = "typescript-language-server";
          args = [ "--stdio" ];
        };
      };
      language = [
        {
          name = "yaml";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "yaml"
            ];
          };
          language-servers = [ "wakatime" ];
        }
        {
          name = "just";
          auto-format = true;
          language-servers = [
            "just-lsp"
            "wakatime"
          ];
          formatter.command = "justformatter";
        }
        {
          name = "cpp";
          auto-format = true;
          language-servers = [
            "clangd"
            "wakatime"
          ];
        }
        {
          name = "rust";
          auto-format = true;
          formatter.command = "cargo fmt";
          injection-regex = "rsx";
          language-servers = [
            "rust-analyzer"
            "wakatime"
          ];
          grammar = "rust";
          scope = "source.rust";
          file-types = [
            "rs"
            "rsx"
          ];
        }
        {
          name = "nix";
          auto-format = true;
          language-servers = [
            "nixd"
            "wakatime"
          ];
          formatter = {
            command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt-rfc-style";
            args = [ "-s" ];
          };
        }
        {
          name = "go";
          auto-format = true;
          language-servers = [
            "gopls"
            "wakatime"
          ];
          formatter.command = "gofumpt";
        }
        {
          name = "zig";
          auto-format = true;
          formatter = {
            command = "zig";
            args = [
              "fmt"
              "--stdin"
            ];
          };
          language-servers = [
            "zls"
            "wakatime"
          ];
        }
        {
          name = "markdown";
          auto-format = true;
          formatter = {
            command = "dprint";
            args = [
              "fmt"
              "--stdin"
              "md"
            ];
          };
          language-servers = [ "wakatime" ];
        }
        {
          name = "javascript";
          auto-format = true;
          formatter = {
            command = "prettierd";
            args = [
              "--stdin-filepath"
              "file.js"
            ];
          };
          language-servers = [
            "typescript-language-server"
            "wakatime"
          ];
        }
        {
          name = "typescript";
          auto-format = true;
          formatter = {
            command = "prettierd";
            args = [
              "--stdin-filepath"
              "file.ts"
            ];
          };
          language-servers = [
            "typescript-language-server"
            "wakatime"
          ];
        }
        {
          name = "jsx";
          auto-format = true;
          formatter = {
            command = "prettierd";
            args = [
              "--stdin-filepath"
              "file.jsx"
            ];
          };
          language-servers = [
            "typescript-language-server"
            "wakatime"
          ];
        }
        {
          name = "tsx";
          auto-format = true;
          formatter = {
            command = "prettierd";
            args = [
              "--stdin-filepath"
              "file.tsx"
            ];
          };
          language-servers = [
            "typescript-language-server"
            "wakatime"
          ];
        }
        {
          name = "json";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "json"
            ];
          };
          language-servers = [ "wakatime" ];
        }
        {
          name = "java";
          auto-format = true;
          language-servers = [
            "jdtls"
            "wakatime"
          ];
        }
        {
          name = "kotlin";
          auto-format = true;
          language-servers = [
            "kotlin-language-server"
            "wakatime"
          ];
        }
      ];
    };
    settings = {
      theme = "rose_transparent";
      editor = {
        line-number = "relative";
        true-color = true;
        soft-wrap.enable = true;
        bufferline = "multiple";
        auto-pairs = true;
        shell = [
          "zsh"
          "-c"
        ];
        end-of-line-diagnostics = "hint";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          hidden = true;
          git-ignore = true;
        };
        statusline = {
          left = [
            "mode"
            "spinner"
          ];
          center = [ "file-name" ];
          right = [
            "diagnostics"
            "position"
            "file-type"
          ];
          separator = "│";
        };
        auto-save = {
          focus-lost = true;
          after-delay.enable = true;
        };
        inline-diagnostics = {
          cursor-line = "warning";
          other-lines = "disable";
        };
      };
      keys = {
        insert = {
          j.k = [
            "normal_mode"
          ];
        };
        normal = {
          g.a = [
            "code_action"
          ];
        };
      };
    };
  };
}
