# 🎨 Hyprland Dotfiles

[English](README.md) | [Русский](README.ru.md)

My personal **Hyprland configuration for Arch Linux** with dynamic themes, custom scripts, and deep system-wide customization.

![Hyprland](https://img.shields.io/badge/Hyprland-0.52.2-blue)
![Waybar](https://img.shields.io/badge/Waybar-0.14.0-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📸 Screenshots

![Nord Theme](screenshots/nord.png)
![Catppuccin Theme](screenshots/catppuccin.png)
![Tokyo Night Theme](screenshots/tokyonight.png)
![GruvBox Theme](screenshots/gruvbox.png)
![Apps menu (rofi launcher)](screenshots/launcher.png)
![Power Menu](screenshots/powermenu.png)
![Windows](screenshots/windows.png)

---

## 🖥️ System Information

* **OS**: Arch Linux
* **WM**: Hyprland 0.52.2
* **Terminal**: Kitty
* **Panel**: Waybar
* **Notifications**: SwayNC
* **Launcher**: Rofi (Wayland)
* **File Manager**: Thunar
* **Screen Lock**: Hyprlock
* **Display Manager**: SDDM (with custom theme)

---

## ✨ Features

### 🎨 Dynamic Theme Switching

* **4 color schemes**: Nord, Catppuccin Mocha, Tokyo Night, Gruvbox
* **Unified theme switching** updates:

  * Hyprland colors and borders
  * Waybar styles
  * Rofi menus (launcher, power menu, clipboard, calendar, window switcher)
  * SwayNC notifications
  * Hyprlock lock screen
  * SDDM login screen
* **Keybindings**:

  * `SUPER + T` — theme menu
  * `SUPER + SHIFT + T` — cycle themes

### 🪟 Window Management

* Dynamic workspace indicators with application icons
* Window switcher: `SUPER + Tab` (Rofi)
* Smart window rules (browser → workspace, dialogs → floating)
* Subtle transparency for inactive windows (92%)

### 🔔 Notifications & Status Bar

* Custom Waybar modules:

  * CPU & memory (click opens `btop`)
  * Temperature monitoring
  * Network (WiFi / Ethernet)
  * Keyboard layout indicator (EN / RU)
  * Battery with color-coded levels
  * Bluetooth status
  * Volume & brightness
* Notification center: `SUPER + N`
* Calendar widget on clock click

### 🎵 Multimedia

* Volume & brightness OSD
* Media player integration
* Hardware media keys support

### 🖼️ Wallpaper Management

* Dynamic wallpapers via **SWWW**
* Wallpaper persistence
* SDDM uses current wallpaper
* Keybindings:

  * `SUPER + W` — next
  * `SUPER + SHIFT + W` — previous
  * `SUPER + CTRL + W` — random

### ⌨️ Keyboard Layout

* English / Russian (`Alt + Shift`)
* Visual indicator in Waybar
* Color-coded state

### 📋 Clipboard & Screenshots

* Clipboard history: `SUPER + V`
* Screenshots:

  * `Print` — full screen
  * `Shift + Print` — area
  * `Ctrl + Print` — active window
* Saved to `~/Pictures/Screenshots/`

### 🔒 Security & Power Management

* Hyprlock with blur and theming
* Polkit authentication agent
* Hypridle:

  * Dim: 4 min
  * Screen off: 5 min
  * Auto-lock: 5 min

---

## 📦 Components & Dependencies

### Core

* `hyprland`, `hyprlock`, `hypridle`, `xdg-desktop-portal-hyprland`

### UI

* `waybar`, `swaync`, `rofi`

### File Management

* `thunar`, `thunar-volman`, `gvfs`

### Utilities

* `kitty`, `wl-clipboard`, `cliphist`, `grim`, `slurp`, `swww`, `playerctl`, `brightnessctl`, `socat`

### System

* `polkit-gnome`, `networkmanager`, `nm-connection-editor`, `bluez`, `bluez-utils`, `blueman`
* `pipewire`, `pipewire-pulse`, `wireplumber`, `pavucontrol`

### Fonts

* `ttf-jetbrains-mono-nerd`, `ttf-font-awesome`, `noto-fonts`, `noto-fonts-emoji`

### Themes

* `gnome-themes-extra`, `adwaita-icon-theme`

---

## 🚀 Installation

```bash
git clone https://github.com/alnrog/hypr_dotfiles.git ~/dotfiles
cd ~/dotfiles

chmod +x install.sh
./install.sh

chmod +x symlink.sh
./symlink.sh

# Optional SDDM integration
chmod +x setup-sddm-links.sh
./setup-sddm-links.sh
```

Log out and start Hyprland.

---

## ⌨️ Keybindings (Highlights)

| Keys                | Action          |
| ------------------- | --------------- |
| `SUPER + Return`    | Terminal        |
| `SUPER + D`         | App launcher    |
| `SUPER + E`         | File manager    |
| `SUPER + Q`         | Close window    |
| `SUPER + Shift + Q` | Exit Hyprland   |
| `SUPER + Esc`       | Power menu      |
| `SUPER + Tab`       | Window switcher |
| `SUPER + V`         | Clipboard       |
| `SUPER + N`         | Notifications   |
| `SUPER + T`         | Theme menu      |

---

## 📁 Project Structure

```text
.config/
├── hypr/
├── waybar/
├── rofi/
├── swaync/
├── kitty/
├── gtk-3.0/
├── gtk-4.0/
└── networkmanager-dmenu/
```

---

## 📄 License

MIT License — see [LICENSE](LICENSE).

---

👤 **Author**: Alnrog
📬 **Contact**: [https://t.me/pen_in_nostril](https://t.me/pen_in_nostril)
