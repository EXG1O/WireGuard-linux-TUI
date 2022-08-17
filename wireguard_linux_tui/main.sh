echo "Программа: WireGuard linux TUI"
echo "Автор программы: https://github.com/EXG1O"
echo ""

# Функция для проверки подключения к серверу
function check_connect() {
	connect_statistics=$(sudo wg show)
	if [[ $connect_statistics == "" ]]
	then
		return 0
	else
		return 1
	fi
}

# Функция для выхода из программы
function exit_from_program() {
	clear
	exit
}

# Функция для добавления WireGuard конфиг файла в директорию /etc/wireguard/
function add_wireguard_config_file() {
	echo -n ":: Введите путь к WireGuard конфиг файлу: "
	read file_path
	
	find_file=$(sudo python main.py "find_file('$file_path')")
	if [[ $find_file == "True" ]]
	then
		sudo cp $file_path /etc/wireguard/

		clear
		echo "WireGuard конфиг файл $file_path успешно скопирован в директорию /etc/wireguard/."
		echo ""
	else
		clear

		if [[ $find_file == "False" ]]
		then
			echo -e "\033[31mWireGuard конфиг файл не был найден по пути $file_path!\033[0m"
			echo ""
		else
			echo -e "\033[31m$find_file\033[0m"
			echo ""
		fi
	fi
}

# Функция для удаления WireGuard конфиг файла из директории /etc/wireguard/
function delete_wireguard_config_file() {
	echo ""
	echo "Все ваши WireGuard конфиг файлы:"
	echo $(sudo python main.py "get_wireguard_confings()")
	echo ""

	echo -n ":: Введите номер WireGuard конфиг файла: "
	read wireguard_conf_num

	wireguard_conf=$(sudo python main.py "get_wireguard_confing('$wireguard_conf_num')")
	if [[ $wireguard_conf == "False_1" ]]
	then
		clear
		echo -e "\033[31mВы ввели не число!\033[0m"
		echo ""
	else
		if [[ $wireguard_conf == "False_2" ]]
		then
			clear
			echo -e "\033[31mНе существует WireGuard конфиг файла под номером $wireguard_conf_num!\033[0m"
			echo ""
		else
			sudo rm -rf /etc/wireguard/$wireguard_conf.conf

			clear
			echo "WireGuard конфиг файл $wireguard_conf.conf был успешно удалён в директории /etc/wireguard/."
			echo ""
		fi
	fi
}

# Функция для подключения к серверу
function connect_to_server() {
	check_connect
	if [[ $? == 0 ]]
	then
		echo ""
		echo "Все ваши WireGuard конфиг файлы:"
		echo $(sudo python main.py "get_wireguard_confings()")
		echo ""

		echo -n ":: Введите номер WireGuard конфиг файла: "
		read wireguard_conf_num

		wireguard_conf=$(sudo python main.py "get_wireguard_confing('$wireguard_conf_num')")
		if [[ $wireguard_conf == "False_1" ]]
		then
			clear
			echo -e "\033[31mВы ввели не число!\033[0m"
			echo ""
		else
			if [[ $wireguard_conf == "False_2" ]]
			then
				clear
				echo -e "\033[31mНе существует WireGuard конфиг файла под номером $wireguard_conf_num!\033[0m"
				echo ""
			else
				clear
				sudo wg-quick up $wireguard_conf
				echo ""
			fi
		fi
	else
		clear
		echo -e "\033[31mВы уже подключины к одному серверу!\033[0m"
		echo ""
	fi 
}

# Функция для показа статистики подключения
function show_connect_statistics() {
	check_connect
	if [[ $? == 1 ]]
	then
		clear
		sudo wg show
		echo ""
	else
		clear
		echo -e "\033[31mВы не подключины к серверу!\033[0m"
		echo ""
	fi
}

# Функция для отключения от серверу
function disconnect_from_server () {
	echo ""
	echo "Все ваши WireGuard конфиг файлы:"
	echo $(sudo python main.py "get_wireguard_confings()")
	echo ""

	echo -n ":: Введите номер WireGuard конфиг файла: "
	read wireguard_conf_num

	wireguard_conf=$(sudo python main.py "get_wireguard_confing('$wireguard_conf_num')")
	if [[ $wireguard_conf == "False_1" ]]
	then
		clear
		echo -e "\033[31mВы ввели не число!\033[0m"
		echo ""
	else
		if [[ $wireguard_conf == "False_2" ]]
		then
			clear
			echo -e "\033[31mНе существует WireGuard конфиг файла под номером $wireguard_conf_num!\033[0m"
			echo ""
		else
			clear
			sudo wg-quick down $wireguard_conf
			echo ""
		fi
	fi
}

# Функция для показа доступных команд в программе
function show_commands_menu() {
	while :
	do
		echo "Список команд:"
		echo "0 - Чтобы выйти из программы;"
		echo "1 - Добавить WireGuard конфиг файл;"
		echo "2 - Удалить WireGuard конфиг файл;"
		echo "3 - Подключится к серверу;"
		echo "4 - Посмотреть статистику подключения;"
		echo "5 - Отключиться от сервера."
		echo ""

		echo -n ":: Введите номер команды [0/1/2/3/4/5]: "
		read select_command
		if [[ $select_command == "0" ]]
		then
			exit_from_program
		else
			if [[ $select_command == "1" ]]
			then
				add_wireguard_config_file
			else
				if [[ $select_command == "2" ]]
				then
					delete_wireguard_config_file
				else
					if [[ $select_command == "3" ]]
					then
						connect_to_server
					else
						if [[ $select_command == "4" ]]
						then
							show_connect_statistics
						else
							if [[ $select_command == "5" ]]
							then
								disconnect_from_server
							else
								clear

								echo -e "\033[31mКоманды $select_command не существует!\033[0m"
								echo ""
							fi
						fi
					fi
				fi
			fi
		fi
	done
}

# Условие для проверки был ли создан файл wireguard_tools_status.txt в директории program_data
find_file=$(sudo python main.py "find_file('./wireguard_tools_status.txt')")
if [[ $find_file == "False" ]]
then
	echo "Wireguard-tools package not installed" > wireguard_tools_status.txt
fi

# Условие для проверки установлен ли wireguard-tools пакет
wireguard_tools_status=$(cat wireguard_tools_status.txt)
if [[ $wireguard_tools_status == "Wireguard-tools package not installed" ]]
then
	echo -n ":: У вас установлен wireguard-tools пакет? [Y/N]: "
	read user_answer
	declare -l user_answer
	user_answer=$user_answer

	if [ $user_answer == "y" ]
	then
		echo "Wireguard-tools package installed" > wireguard_tools_status.txt
		echo ""

		clear
		show_commands_menu
	else
		clear
		echo -e "\033[31mУстоновите wireguard-tools пакет!\033[0m"
		echo ""
	fi
else
	clear
	show_commands_menu
fi