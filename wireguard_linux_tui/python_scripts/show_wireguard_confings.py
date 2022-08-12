import os

if __name__ == '__main__':
	wireguard_confings_list, num = '', 1
	for wireguard_conf in os.listdir('/etc/wireguard/'):
		wireguard_confings_list += f"{num}. {wireguard_conf.replace('.conf', '')}\n"
		num += 1
	print(wireguard_confings_list)