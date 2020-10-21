#!/bin/bash

# Funció que llegeix els processos executats
# l'ultim minut, 5 minuts i 15 minuts de 
# /proc/loadavg i els imprimeix
function procavg {
	res_loadavg=`cat /proc/loadavg`
	res_arr=($res_loadavg)
	echo "Nombre mig de processos executant-se a la CPU"
	echo "1 minut	5 minuts	15 minuts"
	echo "${res_arr[0]}	${res_arr[1]}		${res_arr[2]}"
}

# Funció que llegeix la memòria total i la
# memòria lliure al sistema desde /proc/meminfo
# i fa una crida a python3 per a poder dividir
# amb punt flotant i donar el percentatge
function memperc {
	res_meminfo=`cat /proc/meminfo`
	res_arr=($res_meminfo)
	tot_mem=${res_arr[1]}
	free_mem=${res_arr[4]}
	perc_str="print(round(100-($free_mem/$tot_mem*100),2),end=\"%\n\")"
	echo "Percentatge de memòria ocupada"
	echo -n $perc_str | python3
}

# Bucle infinit que es trencarà al prémer
# l'usuari CTRL+C i que repetidament crida
# a les 2 funcions anteriors, espera un segon
# i neteja la pantalla
while true
do
	procavg
	echo
	memperc
	sleep 1
	clear
done
