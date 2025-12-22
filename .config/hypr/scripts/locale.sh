#!/usr/bin/env bash
# Centralized localization for dotfiles
# Source this file in your scripts: source ~/.config/hypr/scripts/locale.sh

# Detect system locale
DOTFILES_LOCALE="${LANG:-en_US.UTF-8}"

# Translation function
t() {
    local key="$1"
    local lang="en"
    
    # Detect language from locale
    [[ "$DOTFILES_LOCALE" =~ ^ru ]] && lang="ru"
    
    # Translation database
    case "$key" in
        # General
        "loading") [[ "$lang" == "ru" ]] && echo "Загрузка..." || echo "Loading..." ;;
        "error") [[ "$lang" == "ru" ]] && echo "Ошибка" || echo "Error" ;;
        "success") [[ "$lang" == "ru" ]] && echo "Успешно" || echo "Success" ;;
        "warning") [[ "$lang" == "ru" ]] && echo "Внимание" || echo "Warning" ;;
        
        # Volume
        "volume") [[ "$lang" == "ru" ]] && echo "Громкость" || echo "Volume" ;;
        "muted") [[ "$lang" == "ru" ]] && echo "Звук выключен" || echo "Muted" ;;
        
        # Brightness
        "brightness") [[ "$lang" == "ru" ]] && echo "Яркость" || echo "Brightness" ;;
        
        # Media
        "playing") [[ "$lang" == "ru" ]] && echo "Воспроизведение" || echo "Playing" ;;
        "paused") [[ "$lang" == "ru" ]] && echo "Пауза" || echo "Paused" ;;
        "stopped") [[ "$lang" == "ru" ]] && echo "Остановлено" || echo "Stopped" ;;
        
        # Theme
        "theme_applied") [[ "$lang" == "ru" ]] && echo "Тема применена" || echo "Theme Applied" ;;
        "switched_to") [[ "$lang" == "ru" ]] && echo "Переключено на" || echo "Switched to" ;;
        "theme") [[ "$lang" == "ru" ]] && echo "Тема" || echo "Theme" ;;
        "select_theme") [[ "$lang" == "ru" ]] && echo "Выберите тему" || echo "Select Theme" ;;
        "theme_error") [[ "$lang" == "ru" ]] && echo "Тема не найдена" || echo "Theme not found" ;;
        
        # Wallpaper
        "wallpaper") [[ "$lang" == "ru" ]] && echo "Обои" || echo "Wallpaper" ;;
        "wallpaper_changed") [[ "$lang" == "ru" ]] && echo "Обои изменены" || echo "Wallpaper changed" ;;
        "no_wallpapers") [[ "$lang" == "ru" ]] && echo "Обои не найдены" || echo "No wallpapers found" ;;
        
        # Screenshot
        "screenshot") [[ "$lang" == "ru" ]] && echo "Скриншот" || echo "Screenshot" ;;
        "screenshot_captured") [[ "$lang" == "ru" ]] && echo "Скриншот сохранён" || echo "Screenshot captured" ;;
        "saved_to") [[ "$lang" == "ru" ]] && echo "Сохранено в" || echo "Saved to" ;;
        "area_copied") [[ "$lang" == "ru" ]] && echo "Область скопирована в буфер" || echo "Area copied to clipboard" ;;
        
        # Keyboard
        "keyboard") [[ "$lang" == "ru" ]] && echo "Клавиатура" || echo "Keyboard" ;;
        "russian_layout") [[ "$lang" == "ru" ]] && echo "Русская раскладка" || echo "Russian layout" ;;
        "english_layout") [[ "$lang" == "ru" ]] && echo "English layout" || echo "English layout" ;;
        
        # Calendar
        "today") [[ "$lang" == "ru" ]] && echo "Сегодня" || echo "Today" ;;
        "previous") [[ "$lang" == "ru" ]] && echo "Назад" || echo "Previous" ;;
        "next") [[ "$lang" == "ru" ]] && echo "Далее" || echo "Next" ;;
        
        # Clipboard
        "clipboard") [[ "$lang" == "ru" ]] && echo "Буфер обмена" || echo "Clipboard" ;;
        "search_clipboard") [[ "$lang" == "ru" ]] && echo "Поиск в буфере..." || echo "Search clipboard..." ;;
        "no_clipboard_text") [[ "$lang" == "ru" ]] && echo "Нет выделенного текста" || echo "No selected text" ;;
        "text_converted") [[ "$lang" == "ru" ]] && echo "Текст конвертирован" || echo "Text converted" ;;
        
        # Power menu
        "power") [[ "$lang" == "ru" ]] && echo "Питание" || echo "Power" ;;
        "shutdown") [[ "$lang" == "ru" ]] && echo "Выключить" || echo "Shutdown" ;;
        "reboot") [[ "$lang" == "ru" ]] && echo "Перезагрузить" || echo "Reboot" ;;
        "lock") [[ "$lang" == "ru" ]] && echo "Заблокировать" || echo "Lock" ;;
        "logout") [[ "$lang" == "ru" ]] && echo "Выйти" || echo "Logout" ;;
        "suspend") [[ "$lang" == "ru" ]] && echo "Режим сна" || echo "Suspend" ;;
        
        # Network
        "network") [[ "$lang" == "ru" ]] && echo "Сеть" || echo "Network" ;;
        "connected") [[ "$lang" == "ru" ]] && echo "Подключено" || echo "Connected" ;;
        "disconnected") [[ "$lang" == "ru" ]] && echo "Отключено" || echo "Disconnected" ;;
        "ethernet") [[ "$lang" == "ru" ]] && echo "Ethernet" || echo "Ethernet" ;;
        
        # Battery
        "battery") [[ "$lang" == "ru" ]] && echo "Батарея" || echo "Battery" ;;
        "charging") [[ "$lang" == "ru" ]] && echo "Заряжается" || echo "Charging" ;;
        "charge") [[ "$lang" == "ru" ]] && echo "Заряд" || echo "Charge" ;;
        "ac_power") [[ "$lang" == "ru" ]] && echo "Питание от сети" || echo "AC Power" ;;
        
        # Window management
        "window_switcher") [[ "$lang" == "ru" ]] && echo "Переключатель окон" || echo "Window Switcher" ;;
        "search_windows") [[ "$lang" == "ru" ]] && echo "Поиск окон..." || echo "Search windows..." ;;
        
        # Applications
        "apps") [[ "$lang" == "ru" ]] && echo "Приложения" || echo "Apps" ;;
        "search") [[ "$lang" == "ru" ]] && echo "Поиск..." || echo "Search..." ;;
        
        # Months (for calendar)
        "january") [[ "$lang" == "ru" ]] && echo "Январь" || echo "January" ;;
        "february") [[ "$lang" == "ru" ]] && echo "Февраль" || echo "February" ;;
        "march") [[ "$lang" == "ru" ]] && echo "Март" || echo "March" ;;
        "april") [[ "$lang" == "ru" ]] && echo "Апрель" || echo "April" ;;
        "may") [[ "$lang" == "ru" ]] && echo "Май" || echo "May" ;;
        "june") [[ "$lang" == "ru" ]] && echo "Июнь" || echo "June" ;;
        "july") [[ "$lang" == "ru" ]] && echo "Июль" || echo "July" ;;
        "august") [[ "$lang" == "ru" ]] && echo "Август" || echo "August" ;;
        "september") [[ "$lang" == "ru" ]] && echo "Сентябрь" || echo "September" ;;
        "october") [[ "$lang" == "ru" ]] && echo "Октябрь" || echo "October" ;;
        "november") [[ "$lang" == "ru" ]] && echo "Ноябрь" || echo "November" ;;
        "december") [[ "$lang" == "ru" ]] && echo "Декабрь" || echo "December" ;;
        
        # Default - return key as is
        *) echo "$key" ;;
    esac
}

# Export function for use in other scripts
export -f t
export DOTFILES_LOCALE
