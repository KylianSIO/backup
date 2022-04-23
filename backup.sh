#!/bin/bash

date_start=`date +%d-%m-%Y-%H-%M`;
 
backup_path="/home/kylian/backup";

log_file="/var/log/backup_log.log";

backup_hist="$backup_path/backup_history.log";


date_end=`date +%d-%m-%Y-%H-%M`;


if [ "$1" = "--console" ]
then

	mkdir -p $backup_path;
	echo "Début de la backup : $date_start \n" >> $log_file;
	echo "Début de la Backup : $date_start \n";

	echo "Sauvegarde des clés SSH..." >> $log_file;
	echo "Sauvegarde des clés SSH ...";
	echo "Sauvegarde du ROOT Site Web... " >> $log_file;
	echo "Sauvegarde du ROOT Site Web ...";
	echo "Sauvegarde du Home ... " >> $log_file;
	echo "Sauvegarde du Home ...";
	echo "Sauvegarde de la config Apache + Vhosts ... " >> $log_file;
	echo "Sauvegarde de la config Apache + Vhosts ...";
	echo "Sauvegarde des certificats Apache ... " >> $log_file;
	echo "Sauvegarde des certificats Apache ...";

	tar -zcf $backup_path/Backup-Kylian-Christopher.tar.gz /home/kylian/.ssh /var/www /home /etc/apache2/apache2.conf /etc/apache2/ports.conf /etc/apache2/conf-available /etc/apache2/sites-available >> $log_file

	echo "Fin de la Backup : $date_end" >> $log_file;
	echo "Fin de la Backup : $date_end";

	echo "Backup réalisé le : $date_end" >> $backup_hist;

else

	if ! [ $(id -u) = 0 ]
	then
		echo "\e[0;31m[WARNING] Vous devez lancer le script en root ou avec sudo !"
		
	else

	clear

	echo "\e[0;31m######################################################"
	echo "\e[0;31m######################## \e[01;05m\e[01;35mMENU \e[0;31m########################"
	echo "\e[0;31m######################################################\n"

	echo "\e[01;32mLancer le script de Backup \e[1;37m➟ \e[1;31mB\n"
	echo "\e[01;32mAfficher l'historique des Backup  \e[1;37m➟ \e[1;31mH\n"
        echo "\e[01;32mEnvoyer la dernière Backup sur un autre serveur \e[1;37m➟ \e[1;31mP\n\n"

	echo "\e[1;35mQuitter \e[1;37m➟ \e[1;31mQ\n"

	echo "#####################################################\n\e[1;37m"

	read -p "Entrez votre choix : " choix	
	
	case "$choix" in

		b) 	clear
			
			mkdir -p $backup_path
        		echo "Début de la backup : $date_start \n" >> $log_file
        		echo "Début de la Backup : $date_start \n"

        		echo "Sauvegarde des clés SSH..." >> $log_file
        		echo "Sauvegarde des clés SSH ..."
        		echo "Sauvegarde du ROOT Site Web... " >> $log_file
        		echo "Sauvegarde du ROOT Site Web ..."
       		 	echo "Sauvegarde du Home ... " >> $log_file
        		echo "Sauvegarde du Home ..."
        		echo "Sauvegarde de la config Apache + Vhosts ... " >> $log_file
        		echo "Sauvegarde de la config Apache + Vhosts ..."
        		echo "Sauvegarde des certificats Apache ... " >> $log_file
        		echo "Sauvegarde des certificats Apache ..."

        		tar -zcf $backup_path/Backup-Kylian-Christopher.tar.gz /home/kylian/.ssh /var/www /home /etc/apache2/apache2.conf /etc/apache2/ports.conf /etc/apache2/conf-available /etc/apache2/sites-available >> $log_file


        		echo "Fin de la Backup : $date_end" >> $log_file
        		echo "Fin de la Backup : $date_end"

        		echo "Backup réalisé le : $date_end" >> $backup_hist
			;;


		"h"|"H") 	clear

			cat $backup_path/backup_history.log
			;;

		"p"|"P") clear
			
			echo "Envoie de la dernière backup vers le nouveau serveur ..." >> $log_file

			last_backup= find /home/kylian/backup -maxdepth 1 -name "*.gz" -ctime 0
			
			scp -r -p $last_backup user@serveur:/home/user/backup 		
			;;

		"q"|"Q") clear 
			 echo "Vous venez de quitter le menu ..." 

		esac
		
	fi	
	

fi


