#!/bin/bash

#Список хостов
USER="dem"
HOSTS="192.168.1.145 192.168.1.222 192.168.1.212 192.168.1.69 192.168.1.98 192.168.1.60"
#HOSTS="192.168.1.98"

echo "Enter password for establishing ssh-session: "
read -s pass
echo -e "Enter password for root user of mysql: "
read -s mysqlpass
echo -e "Enter password for replication user of mysql: "
read -s replicapass
echo -e "Enter password for Wordpress user: "			
read -s wp

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
				     sudo rm -r /etc/nginx;
				     sudo rm -r /etc/filebeat;
				     sudo cp -r /home/dem/configs/nginx /etc;
				     sudo cp -r /home/dem/configs/filebeat /etc;
				     sudo systemctl restart nginx;
				     sudo systemctl restart filebeat;
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
				     sudo rm -r /etc/apache2;
				     sudo cp -r /home/dem/configs/apache2 /etc;				     
				     sudo cp -r /home/dem/configs/wordpress /var/www/html;
				     sudo chown -R www-data:www-data /var/www/html/wordpress;
				     sudo systemctl restart apache2;
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
				     sudo rm -r /etc/apache2;
				     sudo cp -r /home/dem/configs/apache2 /etc;				    
				     sudo cp -r /home/dem/configs/wordpress /var/www/html;
				     sudo chown -R www-data:www-data /var/www/html/wordpress;
				     sudo systemctl restart apache2;
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
				     sudo rm /var/lib/mysql/auto.cnf;
				     sudo rm -r /etc/mysql;
				     sudo cp -r /home/dem/configs/mysql /etc;
				     sudo systemctl restart mysql;
				     echo -e \"[mysql]\nuser='root'\npassword='$mysqlpass'\n\" > ~/.my.cnf;
				     sudo mysql -e \"ALTER USER 'root'@'localhost' IDENTIFIED WITH 'caching_sha2_password' BY '$mysqlpass'\";
					 mysql -e \"CREATE USER repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY '$replicapass'\";
					 mysql -e \"GRANT REPLICATION SLAVE ON *.* TO repl@'%'\";
					 mysql -e \"CREATE USER wp_user@'%' IDENTIFIED BY '$wp'\";
					 mysql -e \"GRANT ALL PRIVILEGES ON wpress_db.* TO wp_user@'%'\";
					 mysql -e \"GRANT ALL PRIVILEGES ON wpress_db_dbl.* TO wp_user@'%'\";				    				     
				     sh /home/dem/configs/load_db.sh;
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
				     sudo rm /var/lib/mysql/auto.cnf;
				     sudo rm -r /etc/mysql;
				     sudo cp -r /home/dem/configs/mysql /etc;
				     echo -e \"[mysql]\nuser='root'\npassword='$mysqlpass'\n\" > ~/.my.cnf;
				     sudo mysql -e \"ALTER USER 'root'@'localhost' IDENTIFIED WITH 'caching_sha2_password' BY '$mysqlpass'\";
				     sudo systemctl restart mysql;
				     sh /home/dem/configs/load_db.sh;
				     mysql -e \"STOP REPLICA\";
					 mysql -e \"RESET REPLICA ALL\";
				     mysql -e \"CHANGE REPLICATION SOURCE TO SOURCE_HOST='192.168.1.69', SOURCE_USER='repl', SOURCE_PASSWORD='$replicapass', SOURCE_AUTO_POSITION = 1, GET_SOURCE_PUBLIC_KEY = 1 \";
				     mysql -e \"START REPLICA\";
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
				     sudo rm -r /etc/prometheus;
				     sudo cp -r /home/dem/configs/prometheus /etc;
				     sudo dpkg -i grafana_10.2.2_amd64.deb;
				     sudo apt -f install;
				     sudo dpkg -i elasticsearch-8.9.1-amd64.deb;
				     sudo apt -f install;
				     sudo rm -r /etc/elasticsearch;
				     sudo cp -r /home/dem/configs/elasticsearch /etc;
				     sudo chown -R root:elasticsearch /etc/elasticsearch;
				     sudo dpkg -i logstash-8.9.1-amd64.deb;
				     sudo apt -f install;
				     sudo rm -r /etc/logstash;
				     sudo cp -r /home/dem/configs/logstash /etc;
				     sudo dpkg -i kibana-8.9.1-amd64.deb;
				     sudo apt -f install;
				     sudo rm -r /etc/kibana;
				     sudo cp -r /home/dem/configs/kibana /etc;
				     sudo chown -R root:kibana /etc/kibana;
				     sudo systemctl daemon-reload;
				     sudo systemctl enable --now grafana-server;
				     sudo systemctl enable --now elasticsearch.service;
				     sudo systemctl enable --now kibana.service;
				     sudo systemctl enable --now logstash.service;
					 sudo systemctl restart prometheus;
				    ";;
    esac
done

exit 0
