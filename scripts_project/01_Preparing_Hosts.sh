#!/bin/bash

#Список хостов
USER="dem"
HOSTS="192.168.1.145 192.168.1.222 192.168.1.212 192.168.1.69 192.168.1.98 192.168.1.60"
#HOSTS="192.168.1.145 192.168.1.222 192.168.1.212"
echo "Enter password for sudo: "
read -s pass
for H in $HOSTS
do
    case "$H" in
    192.168.1.145)
		    rsync -avz /home/dem/configurations/front_nginx_conf/* $USER@$H:/home/dem/configs
		    sshpass -p $pass ssh -t $USER@$H "
					 sudo hostnamectl set-hostname front-nginx;
				     sudo rm -f /etc/machine-id;
				     sudo dbus-uuidgen --ensure=/etc/machine-id;
					 sudo timedatectl set-timezone Europe/Moscow;
				     sudo apt update;
				     sudo apt install -y nginx prometheus-node-exporter mc;
				     sudo apt -f install;
				     cd /home/dem/configs;
				     sudo dpkg -i filebeat-8.9.1-amd64.deb;
				     sudo apt -f install;
				     sudo systemctl enable --now filebeat.service;
				    ";;
    192.168.1.222)
		    rsync -avz /home/dem/configurations/first_apache_conf/* $USER@$H:/home/dem/configs
		    sshpass -p $pass ssh -t $USER@$H "
					 sudo hostnamectl set-hostname first-apache;
				     sudo rm -f /etc/machine-id;
				     sudo dbus-uuidgen --ensure=/etc/machine-id;
   					 sudo timedatectl set-timezone Europe/Moscow;
				     sudo apt update;
				     sudo apt install -y apache2 php php-mysql libapache2-mod-rpaf libapache2-mod-php; 
				     sudo apt -f install;
				     sudo apt install -y php-cli php-cgi php-gd prometheus-node-exporter mc;
				     sudo apt -f install;
				     sudo a2enmod rewrite;
				     sudo a2enmod rpaf;
				     sudo a2enmod remoteip;
				     ";;
    192.168.1.212)
		    rsync -avz /home/dem/configurations/second_apache_conf/* $USER@$H:/home/dem/configs
		    sshpass -p $pass ssh -t $USER@$H "
					 sudo hostnamectl set-hostname second-apache;
				     sudo rm -f /etc/machine-id;
				     sudo dbus-uuidgen --ensure=/etc/machine-id;
					 sudo timedatectl set-timezone Europe/Moscow;
				     sudo apt update;
				     sudo apt install -y apache2 php php-mysql libapache2-mod-rpaf libapache2-mod-php;
				     sudo apt -f install;
				     sudo apt install -y php-cli php-cgi php-gd prometheus-node-exporter mc;
				     sudo apt -f install;
				     sudo a2enmod rewrite;
				     sudo a2enmod rpaf;
				     sudo a2enmod remoteip;
				     ";;
    192.168.1.69)
		    rsync -avz /home/dem/configurations/master_mysql_conf/* $USER@$H:/home/dem/configs	
		    sshpass -p $pass ssh -t $USER@$H "
					 sudo hostnamectl set-hostname master-mysql;
				     sudo rm -f /etc/machine-id;
				     sudo dbus-uuidgen --ensure=/etc/machine-id;
					 sudo timedatectl set-timezone Europe/Moscow;
				     sudo apt update;
				     sudo apt install -y mysql-server-8.0 prometheus-node-exporter mc;
				    ";;
    192.168.1.98)
		    rsync -avz /home/dem/configurations/slave_mysql_conf/* $USER@$H:/home/dem/configs
		    sshpass -p $pass ssh -t $USER@$H "
					 sudo hostnamectl set-hostname slave-mysql;
				     sudo rm -f /etc/machine-id;
				     sudo dbus-uuidgen --ensure=/etc/machine-id;
					 sudo timedatectl set-timezone Europe/Moscow;
				     sudo apt update;
				     sudo apt install -y mysql-server-8.0 prometheus-node-exporter mc;
				    ";;
    192.168.1.60)
		    rsync -avz /home/dem/configurations/monitoring_srv_conf/* $USER@$H:/home/dem/configs
		    sshpass -p $pass ssh -t $USER@$H "
					 sudo hostnamectl set-hostname monitoring-srv;
				     sudo rm -f /etc/machine-id;
				     sudo dbus-uuidgen --ensure=/etc/machine-id;
					 sudo timedatectl set-timezone Europe/Moscow;
				     sudo apt update;
				     sudo apt install -y default-jdk;
				     sudo apt -f install;
				     sudo apt install -y prometheus prometheus-node-exporter mc;
				     cd /home/dem/configs;
				     sudo dpkg -i grafana_10.2.2_amd64.deb;
				     sudo apt -f install;
				     sudo dpkg -i elasticsearch-8.9.1-amd64.deb;
				     sudo apt -f install;
				     sudo dpkg -i logstash-8.9.1-amd64.deb;
				     sudo apt -f install;
				     sudo dpkg -i kibana-8.9.1-amd64.deb;
				     sudo apt -f install;
				     sudo systemctl daemon-reload;
				     sudo systemctl enable --now grafana-server;
				     sudo systemctl enable --now elasticsearch.service;
				     sudo systemctl enable --now kibana.service;
				     sudo systemctl enable --now logstash.service;
				    ";;
    esac
done

exit 0
