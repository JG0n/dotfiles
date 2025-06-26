# Dotfiles
![image](https://github.com/user-attachments/assets/1e808faa-da1b-4bf3-881c-782472960373)

![image](https://github.com/user-attachments/assets/fda0d1df-5b76-4ffd-be42-2682d7423ef5)

## Required packages

#### Base
```
sudo pacman -Syu hyprland hyprpaper hypridle hyprlock hyprpaper rofi-wayland
```

#### Hyprpm and plugins
```
sudo pacman -Syu  cmake cpio meson uwsm
```

- [Split workspaces](https://github.com/Duckonaut/split-monitor-workspaces) - If split workspaces is not used change ```source = ~/.config/hypr/configs/keybinds/split-workspace.conf``` in config/hypr/configs/keybindings.conf to ```source = ~/.config/hypr/configs/keybinds/workspace.conf```

#### Nvim (for lsps)
```
sudo pacman -Syu npm go dotnet-sdk dotnet-runtime
```

#### Screenshots
```
sudo pacman -Syu grim slurp jq wl-clipboard gwenview
```

#### Zsh

```
sudo pacman -Syu starship fzf zsh-syntax-highlighting zsh-autosuggestions
```

## Thanks

My waybar dotfiles started off as a mix of [ML4W](https://github.com/mylinuxforwork/dotfiles) and [rubyowo](https://github.com/rubyowo) waybar config.
I mostly use [Catppuccin](https://catppuccin.com/) themes.
