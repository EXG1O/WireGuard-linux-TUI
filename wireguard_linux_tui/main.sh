echo "Программа: WireGuard linux TUI"
echo "Автор программы: https://github.com/EXG1O"
echo ""

function menu_for_commands() {
	while :
	do
		echo "Список команд:"
		echo "0 - Чтобы выйти из программы;"
		echo "1 - Добавить WireGuard конфиг файл;"
		echo "2 - Удалить WireGuard конфиг файл;"
		echo "3 - Подключится к серверу;"
		echo "4 - Отключиться от сервера."
		echo ""

		echo -n ":: Введите номер команды [1/2/3/4]: "
		read select_command

		if [[ $select_command == "1" ]]
		then
			echo -n ":: Введите путь к WireGuard конфиг файлу: "
			read file_path
			
			find_file=$(python python_scripts/find_file.py $file_path)
			if [[ $find_file == "True" ]]
			then
				sudo cp $file_path /etc/wireguard/
				echo "WireGuard конфиг файл $file_path успешно скопирован в /etc/wireguard/."
				echo ""
			else
				if [[ $find_file == "False" ]]
				then
					echo "WireGuard конфиг файл не был найден по пути $file_path!"
					echo ""
				else
					echo $find_file
					echo ""
				fi
			fi
		else
			if [[ $select_command == "2" ]]
			then
				echo ""
				echo "Все ваши WireGuard конфиг файлы:"
				echo $(python python_scripts/show_wireguard_confings.py)
				echo ""

				echo -n ":: Введите название WireGuard конфиг файла: "
				read wireguard_conf

				sudo rm -rf /etc/wireguard/$wireguard_conf.conf
				echo "WireGuard конфиг файл $wireguard_conf.conf был успешно удалён."
				echo ""
			else
				if [[ $select_command == "3" ]]
				then
					echo ""
					echo "Все ваши WireGuard конфиг файлы:"
					echo $(python python_scripts/show_wireguard_confings.py)
					echo ""

					echo -n ":: Введите название WireGuard конфиг файла: "
					read wireguard_conf

					sudo wg-quick up $wireguard_conf
					echo "Вы успешно подключились к серверу по WireGuard конфиг файлу $wireguard_conf."
					echo ""
				else
					if [[ $select_command == "4" ]]
					then
						echo ""
						echo "Все ваши WireGuard конфиг файлы:"
						echo $(python python_scripts/show_wireguard_confings.py)
						echo ""

						echo -n ":: Введите название WireGuard конфиг файла: "
						read wireguard_conf

						sudo wg-quick down $wireguard_conf
						echo "Вы успешно отключились от сервера, по которому вы были подключены поэтому WireGuard конфиг файлу $wireguard_conf."
						echo ""
					else
						echo "Команды $select_command не существует!"
						echo ""
					fi
				fi
			fi
		fi
	done
}

wireguard_tools_status=$(cat program_data/wireguard_tools_status.txt)
if [[ $wireguard_tools_status == "Wireguard-tools package not installed" ]]
then
	echo -n ":: У вас установлен wireguard-tools пакет? [Y/N]: "
	read user_answer
	declare -l user_answer
	user_answer=$user_answer

	if [ $user_answer == "y" ]
	then
		echo "Wireguard-tools package installed" > program_data/wireguard_tools_status.txt
		echo ""
		menu_for_commands
	else
		echo "Устоновите wireguard-tools пакет!"
	fi
else
	menu_for_commands
fi