import sys
import os

if __name__ == '__main__':
	path = sys.argv[1].split('/')
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