#!/bin/bash

# Скрипт для бэкапа таблиц баз MySQL

#   Во внешнем цикле осуществляется перебор имеющихся баз данных. Далее во вложенном цикле 
# происходит подключение к каждой из баз с последующим перебором таблиц, которые направляются
# на обработку утилите mysqldump. Сжатые программой gzip дампы таблиц сохраняются в директориях,
# имеющих имена соответствующих баз данных.

MYSQL='mysql --skip-column-names'

for s in $($MYSQL -e "SHOW DATABASES LIKE '%_db%'")
do
    mkdir $s
    for t in $($MYSQL -e "USE $s; SHOW TABLES")
    do
    /usr/bin/mysqldump --add-drop-table --create-options --disable-keys --extended-insert --single-transaction --quick --events --routines --set-gtid-purged=OFF --triggers --source-data=0 --skip-lock-tables --flush-privileges $s $t | gzip -1 > $s/$t.sql.gz
    done
done

for i in $($MYSQL -e "SHOW DATABASES WHERE \`Database\` LIKE 'information_schema' OR \`Database\` LIKE 'mysql' OR \`Database\` LIKE 'performance_schema' OR \`Database\` LIKE 'sys'")
do
    mkdir $i
    /usr/bin/mysqldump --add-drop-table --create-options --disable-keys --extended-insert --single-transaction --quick --events --routines --set-gtid-purged=OFF --triggers --source-data=0 --skip-lock-tables --flush-privileges $i | gzip -1 > $i/$i.sql.gz
done
