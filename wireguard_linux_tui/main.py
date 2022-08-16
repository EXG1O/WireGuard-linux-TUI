from curses.ascii import isdigit
import sys
import os

def find_file(path: str):
	path = path.split('/')
	directory = '/'.join(path[0:-1])
	file_name = path[-1]
	
	try:
		find_file_name = False
		for file_name_ in os.listdir(directory):
			if file_name_ == file_name:
				find_file_name = True
				break

		print(find_file_name)
	except FileNotFoundError:
		print('Такой директории не существует!')

def get_wireguard_confings():
	wireguard_confings_list, num = '', 1
	for wireguard_conf in os.listdir('/etc/wireguard/'):
		wireguard_confings_list += f"{num} - {wireguard_conf.replace('.conf', '')}\n"
		num += 1

	print(wireguard_confings_list)

def get_wireguard_confing(num: str):
	if num.isdigit():
		num = int(num)
		wireguard_dir = os.listdir('/etc/wireguard/')
		if len(wireguard_dir) <= num:
			print(os.listdir('/etc/wireguard/')[num - 1].replace('.conf', ''))
		else:
			print('False_2')
	else:
		print('False_1')

if __name__ == '__main__':
	eval(sys.argv[1])
