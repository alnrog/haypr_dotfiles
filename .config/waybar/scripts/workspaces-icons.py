#!/usr/bin/env python3
import json
import subprocess
import sys

# --- Настройка: маппинг class → иконка ---
CLASS_TO_ICON = {
    "kitty": "",
    "firefox": "",
    "code": "󰨞",
    "thunderbird": "",
    "org.telegram.desktop": "",
    "discord": "",
    "obsidian": "󱓧",
    "pavucontrol": "󰕾",
    "blueman-manager": "󰂯",
    "default": ""
}

# --- Получаем список воркспейсов и окон ---
def get_hyprland_data():
    try:
        workspaces_raw = subprocess.check_output(["hyprctl", "workspaces", "-j"], text=True)
        clients_raw = subprocess.check_output(["hyprctl", "clients", "-j"], text=True)
        monitors_raw = subprocess.check_output(["hyprctl", "monitors", "-j"], text=True)
        return json.loads(workspaces_raw), json.loads(clients_raw), json.loads(monitors_raw)
    except Exception as e:
        print(json.dumps({"text": "", "alt": "error", "class": "error"}), flush=True)
        sys.exit(1)

def get_icon_for_class(cls):
    return CLASS_TO_ICON.get(cls.lower(), CLASS_TO_ICON["default"])

def main():
    workspaces, clients, monitors = get_hyprland_data()

    # Текущий активный workspace
    active_ws = next((ws["id"] for ws in workspaces if ws["focused"]), 1)

    # Собираем маппинг: workspace_id -> список иконок
    ws_icons = {}
    for client in clients:
        if client["mapped"]:  # только видимые окна
            ws = client["workspace"]["id"]
            cls = client["class"]
            if cls:  # пропускаем пустые классы
                icon = get_icon_for_class(cls)
                if ws not in ws_icons:
                    ws_icons[ws] = []
                ws_icons[ws].append(icon)

    # Формируем строки для каждого workspace
    output = []
    for ws in sorted(ws_icons.keys()):
        icons = ws_icons[ws]
        # Убираем дубликаты, если нужно:
        # icons = list(dict.fromkeys(icons))
        icon_str = "".join(icons)
        output.append({
            "text": icon_str if icon_str else f"{ws}",
            "alt": str(ws),  # для on-click
            "class": "active" if ws == active_ws else "inactive"
        })

    # Если workspace пуст — всё равно показываем его номер
    all_ws_ids = {ws["id"] for ws in workspaces}
    for ws_id in sorted(all_ws_ids):
        if ws_id not in ws_icons:
            output.append({
                "text": str(ws_id),
                "alt": str(ws_id),
                "class": "active" if ws_id == active_ws else "inactive"
            })

    print(json.dumps(output), flush=True)

if __name__ == "__main__":
    main()
