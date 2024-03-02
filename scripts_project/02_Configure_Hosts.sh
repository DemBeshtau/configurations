#!/bin/bash

#Список хостов
USER="dem" 
#HOSTS="192.168.1.145 192.168.1.222 192.168.1.212 192.168.1.69 192.168.1.98 192.168.1.60"
HOSTS="192.168.1.145 192.168.1.222 192.168.1.212"

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
			echo -e "\n========== Configuring front-nginx server ==========\n"		    
			sshpass -p $pass ssh -t $USER@$H "
				     sudo rm -r /etc/nginx;
				     sudo rm -r /etc/filebeat;
				     sudo cp -r /home/dem/configs/nginx /etc;
				     sudo cp -r /home/dem/configs/filebeat /etc;
				     sudo systemctl restart nginx;
				     sudo systemctl restart filebeat;
				    ";;
    192.168.1.222)
			echo -e "\n========== Configuring first-apache server ==========\n"
		    sshpass -p $pass ssh -t $USER@$H "
				     sudo rm -r /etc/apache2;
				     sudo cp -r /home/dem/configs/apache2 /etc;
				     sudo cp -r /home/dem/configs/wordpress /var/www/html;
				     sudo chown -R www-data:www-data /var/www/html/wordpress;
				     sudo systemctl restart apache2;
				     ";;
    192.168.1.212)
			echo -e "\n========== Configuring second-apache server ==========\n"
		    sshpass -p $pass ssh -t $USER@$H "
				     sudo rm -r /etc/apache2;
				     sudo cp -r /home/dem/configs/apache2 /etc;
				     sudo cp -r /home/dem/configs/wordpress /var/www/html;
				     sudo chown -R www-data:www-data /var/www/html/wordpress;
				     sudo systemctl restart apache2;
				     ";;
    192.168.1.69)
			echo -e "\n========== Configuring master-mysql server ==========\n"
		    sshpass -p $pass ssh -t $USER@$H "
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
			echo -e "\n========== Configuring slave-mysql server ==========\n"
		    sshpass -p $pass ssh -t $USER@$H "
				     sudo rm /var/lib/mysql/auto.cnf;
				     sudo rm -r /etc/mysql;
				     sudo cp -r /home/dem/configs/mysql /etc;
   				     sudo systemctl restart mysql;
				     echo -e \"[mysql]\nuser='root'\npassword='$mysqlpass'\n\" > ~/.my.cnf;
				     sudo mysql -e \"ALTER USER 'root'@'localhost' IDENTIFIED WITH 'caching_sha2_password' BY '$mysqlpass'\";				     
				     sh /home/dem/configs/load_db.sh;
				     mysql -e \"STOP REPLICA\";
				     mysql -e \"RESET REPLICA ALL\";
				     mysql -e \"CHANGE REPLICATION SOURCE TO SOURCE_HOST='192.168.1.69', SOURCE_USER='repl', SOURCE_PASSWORD='$replicapass', SOURCE_AUTO_POSITION = 1, GET_SOURCE_PUBLIC_KEY = 1\";
				     mysql -e \"START REPLICA\";
				    ";;
    192.168.1.60)
			echo -e "\n========== Configuring monitoring-srv server ==========\n"		    
		    sshpass -p $pass ssh -t $USER@$H "
				     sudo rm -r /etc/prometheus;
				     sudo cp -r /home/dem/configs/prometheus /etc;				     
				     sudo rm -r /etc/elasticsearch;
				     sudo cp -r /home/dem/configs/elasticsearch /etc;
				     sudo chown -R root:elasticsearch /etc/elasticsearch;				     
				     sudo rm -r /etc/logstash;
				     sudo cp -r /home/dem/configs/logstash /etc;				     
				     sudo rm -r /etc/kibana;
				     sudo cp -r /home/dem/configs/kibana /etc;
				     sudo chown -R root:kibana /etc/kibana;
				     sudo systemctl restart grafana-server;
				     sudo systemctl restart elasticsearch;
				     sudo systemctl restart kibana;
				     sudo systemctl restart logstash;
				     sudo systemctl restart prometheus;
				    ";;
    esac
done

exit 0
