#!/bin/bash
# Скрипт установки пакетов для Hyprland на Arch Linux

set -e

# Цвета
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "==================================="
echo "Установка пакетов Hyprland"
echo "==================================="

# Проверка на Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo -e "${RED}Этот скрипт предназначен для Arch Linux${NC}"
    exit 1
fi

# Проверка прав sudo
if ! sudo -v; then
    echo -e "${RED}Требуются права sudo${NC}"
    exit 1
fi

echo -e "${BLUE}Обновляем систему...${NC}"
sudo pacman -Syu --noconfirm

echo ""
echo -e "${GREEN}Устанавливаем основные пакеты...${NC}"

# Основные пакеты
PACKAGES=(
    # Hyprland и зависимости
    "hyprland"
    "hyprlock"
    "hypridle"
    "xdg-desktop-portal-hyprland"
    "sddm"
    "qt6-svg"
    "qt6-declarative"
    
    # Waybar и компоненты
    "waybar"
    "swaync"
    
    # Утилиты для работы с буфером обмена
    "wl-clipboard"
    "cliphist"
    
    # Скриншоты
    "grim"
    "slurp"
    
    # Терминал
    "kitty"
    
    # Файловый менеджер
    "thunar"
    "thunar-volman"
    "gvfs"
    "polkit-gnome"
    
    # Лаунчер
    "rofi"
    
    # Bluetooth
    "bluez"
    "bluez-utils"
    "blueman"
    
    # Network Manager
    "networkmanager"
    "nm-connection-editor"
    
    # Звук
    "pavucontrol"
    "pipewire"
    "pipewire-pulse"
    "wireplumber"
    
    # Утилиты
    "jq"
    "libnotify"
    "brightnessctl"
    "playerctl"
    "socat"
    "swww"
    
    # Шрифты
    "ttf-font-awesome"
    "ttf-jetbrains-mono-nerd"
    "noto-fonts"
    "noto-fonts-emoji"

    #Темы
    "gnome-themes-extra"
    "adwaita-icon-theme"
)

for package in "${PACKAGES[@]}"; do
    if pacman -Qi "$package" &> /dev/null; then
        echo -e "${YELLOW}⊙ $package уже установлен${NC}"
    else
        echo -e "${BLUE}→ Устанавливаем $package...${NC}"
        sudo pacman -S --noconfirm "$package"
    fi
done

echo ""
echo -e "${GREEN}Включаем сервисы...${NC}"
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

echo ""
echo -e "${GREEN}Включаем SDDM...${NC}"
sudo systemctl enable sddm.service

echo ""
echo -e "${GREEN}Готово!${NC}"
echo -e "${BLUE}Теперь можно запустить: ./symlink.sh${NC}"
