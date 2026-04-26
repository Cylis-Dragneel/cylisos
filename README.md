# CylisOS

Personal NixOS flake setup. You can reuse it, fork it, or use it as a template.

## What this flake currently does

- Builds one active NixOS host from `flake.nix` (`host` + `username` in the `let` block)
- Host configs live in `hosts/<name>/`
- Home Manager config is wired through the same flake
- Program modules are split under `programs/`
- Extra system modules are under `modules/`

---

## Prerequisites

From a NixOS live ISO (or any system with Nix + flakes):

```bash
nix-shell -p git vim
```

---

## Install / deploy this flake

### 1) Clone the repo

```bash
cd ~
git clone https://github.com/Cylis-Dragneel/cylisos.git
cd ~/cylisos
```

### 2) Set your active host + username in `flake.nix`

Edit the `let` block in `flake.nix` and set:

- `host = "...";`
- `username = "...";`

If you use an existing host profile, pick one that already exists under `hosts/`.

### 3) (Optional) Create your own host profile

```bash
cp -r hosts/default hosts/<your-hostname>
```

Then set `host = "<your-hostname>";` in `flake.nix`.

### 4) Generate hardware config for that host

```bash
sudo nixos-generate-config --show-hardware-config > hosts/<your-hostname>/hardware.nix
```

If you’re using an existing host profile instead of a new one, update that host’s `hardware.nix` instead.

### 5) Rebuild

```bash
sudo nixos-rebuild switch --flake ~/cylisos#<your-hostname>
```

---

## Typical workflow after install

Inside `~/cylisos`:

```bash
# apply config changes
sudo nixos-rebuild switch --flake .#<your-hostname>

# update inputs
nix flake update
```

If your shell aliases are enabled, you can also use:

- `fr` → rebuild
- `fu` → rebuild with update
- `hms` → Home Manager switch

---

## Notes

- Some host configs include machine-specific values/services. Copying `hosts/default` is usually the safest base.
