#!/bin/bash
clear
sleep 7
echo "==============================================================================================="
echo "===============================  BIENVENUE SUR MON PROJET SYS ================================="
echo "==============================================================================================="
echo "=============================                                   ==============================="
echo "=======================     veuillez choisir l'option à exécuter      ========================="
echo "=============================                                   ===============================" 
echo "==============================================================================================="
echo "===============================================================================================" 
echo "=====                                                                                    ======"                                                                     
echo "=====          a - Informations sur les utilisateurs enregistrés il ya 3 jours           ======"
echo "=====                                                                                    ======"
echo "=====          b - acquisition, installation et lancement de l'environement xampp        ======"
echo "=====                                                                                    ======"
echo "=====          c - archivage des eléments du repertoire personnel modifié  par           ======"
echo "=====                               le sudoer il ya 2 jours                              ======"
echo "=====                                                                                    ======"
echo "=====          d - informations d'utilisation du disque, de la memoire du processeur,    ======"
echo "=====                                     de la swap                                     ======"
echo "=====                                                                                    ======"
echo "=====                                    quitter(Q/q)                                    ======"
echo "=====                                                                                    ======"
echo "=============================================     ============================================="
echo "============================                                           ========================" 
echo "=====                       Programme écris par :  SADJO LEGBANE SARAï                   ======" 
echo "=====                                                                                    ======"          
echo "=====    Etudiant  en Licence 3 Architectures et réseaux à l'Universté de Ngaoundéré     ======"
echo "=====                                    au Cameroun                                     ======"
echo "======================================                ========================================="
echo "==============================================================================================="  

#lecture de l'entree
echo "veuillez entrer votre choix : "
       
read -r option

case $option in 
	
#liste des utilisateurs

	'a') cut -d : -f 1 /etc/passwd>all_user
	
#liste des repertoires se trouvant dans /home 

	ls /home>user_foders
	
	while read line 
	do
		while read line1
		do	
		if [ $line == $line1 ] ; then 
		echo $line1>user1
		fi
		done<user_foders
	done<all_users
	find /home/* -type d -ctime 3 -print>userx

	while read line1
	do
	   while read user
	   do 
	      if [ $line1 == '/home/'$user ] ; then
		echo "le(s) compte(s) enregistré(s) il y a 3 jours sont/est : " 
		echo $user >3days_user.txt
	      fi

	    done<user1 
	done<userx
	cat 3days_users.txt
	
 ;;
	'b') echo "téléchargement  de xampp..."
	 wget https://downloadsapachefriends.global.ssl.fastly.net/xampp-files/5.6.30/xampp-linux-x64-5.6.30-1-installer.run?from_af=true
	 echo " installation..."
	 ./xampp-linux-x64-5.6.30-1-installer.run
	
	 sudo su
	echo "lancement..."
	/opt/lampp/lampp start


;;
	'c') echo "archivage"
	#archivage des fichiers du repertoire home modifiés par le sudoer il ya 2 jours
	mkdir -p /home/seed/archive
	find /home/seed/ -type f -mtime 2 -print>/home/seed/ficmodi
	while read line
	do
	cp $line archive
	done </home/seed/ficmodi
	tar -czvf archive.tar.gz archive
	mv archive.tar.gz /media/seed/usb/*/archive.tar.gz
	;;
	'd') echo "Informations sur l'utilisation du disque :"
		df -h |grep /dev/sd
		echo "Informations sur l'utilisation de la memoire et de la swap :"
		free -h 
;;
	'Q' )  echo "Just smile!!"
	       exit 2 ;;
	'q' )  echo "Just smile!!"
	       exit 2 ;;
	  * )  echo "votre choix n'est pas disponible!!"
               echo "entrez un autre choix : ";;
esac
