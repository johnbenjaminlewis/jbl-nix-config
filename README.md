# **My Nix-Darwin Flake**

This is a reusable [Nix Flake](https://nixos.wiki/wiki/Flakes) for configuring macOS systems
using [nix-darwin](https://www.google.com/search?q=https://github.com/LnL7/nix-darwin)
and [Home Manager](https://github.com/nix-community/home-manager). It is designed as a
library, exposing a `flake.lib.mkHost` function. This allows you to use this
flake as an input and call mkHost to generate a complete darwinConfiguration for any number
of [Darwin] machines.

## **Core Features**

- **Reusable:** Configure multiple hosts from a single, consistent interface.
- **Unified:** Manages both system-level (nix-darwin) and user-level (home-manager)
  settings in a single build.
- **Extensible:** Callers can pass in their own `extraSystemModules` and `extraHomeModules`
  to add or override configurations.

## **Usage**

To use this flake to configure your own Mac, you would create a new flake that has this one
as an input:

````nix
# Your own flake.nix
{
  description = "My personal Mac configuration";

  inputs = {
   nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

      # Point this to your config repo
      my-darwin-config.url = "github:<your-username>/<your-repo-name>";
      my-darwin-config.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, my-darwin-config }:
  let

    # you may write your custom module inline
    customizationModule = ({ pkgs, ... }: {
      home-manager.users.${user.username}.home.packages = with pkgs; [
        nodejs_24
      ];
      homebrew.casks = [
        "utm"  # virtual machine
      ];
    });

  in
  {

      darwinConfigurations."my-macbook" = my-darwin-config.lib.mkHost {
        # --- User Configuration ---
        user = {
         username = "jane";
          firstName = "Jane";
          lastName = "Doe";
          email = "jane@example.com";
        };

        # --- Host Configuration ---
        localhost = {
          hostname = "my-macbook";
          system = "aarch64-darwin"; # or "x86_64-darwin"
        };

        # --- Custom Modules ---
        # Pass in your own nix-darwin modules
        extraSystemModules = [
          ./my-system-settings.nix  # you may refer to an external custom module
          customizationModule
        ];

        # Pass in your own home-manager modules
        extraHomeModules = [
          ./my-neovim-config.nix
          ./my-shell-aliases.nix
        ];
      };

  };
}

### **Configuration Options**

The mkHost function accepts a single attribute set (myconfig) with the following options:

- user: An attribute set containing username, firstName, lastName, and email.
- localhost: An attribute set containing hostname and system (`aarch64-darwin`
  or x86_64-darwin).
- extraSystemModules: A list of Nix-Darwin modules to be imported into the system configuration.
- extraHomeModules: A list of Home Manager modules to be imported into the user's configuration.

## **Building and Applying**

To apply the configuration to your system:

1. Build the system configuration

  ```bash
  nix build .#darwinConfigurations.<hostname>
````

2. Apply the configuration

```bash
./result/bin/darwin-rebuild switch --flake .#<hostname>
```

Once darwin-rebuild is on your path, you can simply run:

```bash
darwin-rebuild switch --flake .#<hostname>
```
