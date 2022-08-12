# WireGuard linux TUI
WireGuard linux TUI - это программа с текстовым пользовательским интерфейсом для управления WireGuard на linux.

# Возможности программы
- Добавлять/удалять WireGuard конфиг файлы;
- Подключаться к WireGuard серверу;
- Отключаться от WireGuard сервера.

# Установка и использовани
1. Устанавливаем wireguard-tools пакет;
2. Устанавливаем для директории /etc/wireguard/ root права:
```sh
sudo chown -R root /etc/wireguard/
```
3. Устанавливаем и запускаем программу:
```sh
git clone https://github.com/EXG1O/WireGuard-linux-TUI.git
cd WireGuard-linux-TUI/wireguard_linux_tui
sh main.sh
```
4. Пользуемся 😊!