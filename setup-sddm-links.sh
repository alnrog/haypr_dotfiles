#!/usr/bin/env bash
set -euo pipefail

# Одноразовая настройка симлинка для SDDM
# Запускается ОДИН РАЗ при первой установке

USER_SDDM_DIR="$HOME/.local/share/sddm"
SYSTEM_SDDM_DIR="/var/lib/sddm"

echo "Настройка SDDM обоев и темы..."

# Создаём директорию пользователя
mkdir -p "$USER_SDDM_DIR"

# Создаём системную директорию
sudo mkdir -p "$SYSTEM_SDDM_DIR"

# Создаём симлинки из системной директории в пользовательскую
sudo ln -sf "$USER_SDDM_DIR/wallpaper.jpg" "$SYSTEM_SDDM_DIR/wallpaper.jpg"
sudo ln -sf "$USER_SDDM_DIR/theme" "$SYSTEM_SDDM_DIR/theme"

# Устанавливаем права
sudo chmod 755 "$SYSTEM_SDDM_DIR"
sudo chown -h $USER:$USER "$SYSTEM_SDDM_DIR/wallpaper.jpg" 2>/dev/null || true
sudo chown -h $USER:$USER "$SYSTEM_SDDM_DIR/theme" 2>/dev/null || true

echo "✓ Симлинки созданы:"
echo "  $SYSTEM_SDDM_DIR/wallpaper.jpg -> $USER_SDDM_DIR/wallpaper.jpg"
echo "  $SYSTEM_SDDM_DIR/theme -> $USER_SDDM_DIR/theme"
echo ""
echo "Теперь можно менять обои и тему БЕЗ sudo!"
