#!/bin/bash
# Скрипт для создания символических ссылок из dotfiles в ~/.config

set -e

# Цвета
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "==================================="
echo "Создание символических ссылок"
echo "==================================="
echo -e "${BLUE}Dotfiles: $DOTFILES_DIR${NC}"
echo -e "${BLUE}Target: $CONFIG_DIR${NC}"
echo ""

# Функция для создания бэкапа
backup_if_exists() {
    local target=$1
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}  Создаём бэкап: $(basename $target) → $(basename $backup)${NC}"
        mv "$target" "$backup"
    elif [ -L "$target" ]; then
        echo -e "${YELLOW}  Удаляем старый симлинк: $(basename $target)${NC}"
        rm "$target"
    fi
}

# Создаём ~/.config если не существует
mkdir -p "$CONFIG_DIR"

# Массив конфигов для линковки
configs=("gtk-3.0" "gtk-4.0" "hypr" "waybar" "swaync" "kitty" "rofi" "networkmanager-dmenu")

echo -e "${GREEN}Создаём симлинки...${NC}"

for config in "${configs[@]}"; do
    source="$DOTFILES_DIR/.config/$config"
    target="$CONFIG_DIR/$config"
    
    if [ -e "$source" ]; then
        backup_if_exists "$target"
        ln -sf "$source" "$target"
        echo -e "${GREEN}✓ $config${NC}"
    else
        echo -e "${YELLOW}⊘ $config (не найден в dotfiles)${NC}"
    fi
done

echo ""
echo -e "${GREEN}Готово!${NC}"
echo -e "${BLUE}Перезапусти Hyprland: SUPER+SHIFT+Q${NC}"
