import json
import os
import sys


def create_pro_dark_theme():
    if len(sys.argv) < 2:
        print("Использование: python3 gen_telegram.py /путь/к/colors.json")
        return

    colors_path = os.path.expanduser(sys.argv[1])

    if not os.path.exists(colors_path):
        print(f"Файл '{colors_path}' не найден.")
        return

    try:
        with open(colors_path, "r") as f:
            wal = json.load(f)

        c = wal["colors"]
        bg = wal["special"]["background"]
        fg = wal["special"]["foreground"]

        # Настройки для максимальной темноты
        real_bg = bg
        darker_bg = c["color0"]  # Самый темный из палитры
        selection_bg = c["color8"]  # Цвет для выделения (серый)
        accent = c["color3"]  # Основной акцент

        # Генерация расширенной темы
        theme_content = f"""
// Основное окно
windowBg: {real_bg};
windowFg: {fg};
windowBgOver: {selection_bg};
windowBgRipple: {darker_bg};
windowFgOver: {fg};
windowSubTextFg: {c['color7']};
windowBoldFg: {fg};
windowActiveTextFg: {accent};

// --- ВАШИ СООБЩЕНИЯ (Исходящие) ---
// Делаем их темными, почти как фон, но с заметной границей или чуть светлее
msgOutBg: {darker_bg}; 
msgOutBgSelected: {selection_bg};
msgOutTxtFg: {fg};
msgOutServiceFg: {accent};
msgOutShadow: #00000000;

// Входящие сообщения
msgInBg: {darker_bg};
msgInBgSelected: {selection_bg};
msgInTxtFg: {fg};
msgInShadow: #00000000;

// --- МЕНЮ И ВЫПАДАЮЩИЕ СПИСКИ ---
// Исправляем отсутствие выделения в меню
menuBg: {real_bg};
menuBgOver: {selection_bg};
menuBgRipple: {darker_bg};
menuFg: {fg};
menuFgOver: {c['color15']};
menuIconFg: {c['color7']};
menuIconFgOver: {accent};

// Списки (выбор в настройках, контакты)
listBgOver: {selection_bg};
listFgOver: {fg};

// Боковая панель (Список чатов)
dialogsBg: {real_bg};
dialogsBgOver: {selection_bg};
dialogsBgActive: {selection_bg};
dialogsNameFg: {fg};
dialogsTextFg: {c['color7']};
dialogsUnreadBg: {accent};
dialogsUnreadFg: {real_bg};

// Поле ввода
historyComposeAreaBg: {real_bg};
historyComposeIconFg: {c['color7']};
historyComposeIconFgOver: {accent};

// Скроллбар
scrollBarBg: {darker_bg}80;
scrollBarBgOver: {selection_bg};

// Кнопки
activeButtonBg: {accent};
activeButtonBgOver: {c['color12']};
activeButtonFg: {real_bg};
"""

        output_path = os.path.expanduser(
            "~/.config/colorschemes/telegram.tdesktop-theme"
        )
        with open(output_path, "w") as f:
            f.write(theme_content)

        print(f"Тема обновлена: {output_path}")

    except Exception as e:
        print(f"Ошибка: {e}")


if __name__ == "__main__":
    create_pro_dark_theme()
