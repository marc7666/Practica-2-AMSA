#!/bin/bash

# Funció que comprova la mida del procés a 
# /proc/[pid]/status
function checkmem {
	if [[ -f "/proc/$1/status" ]]
	then
		res_status=`cat /proc/$1/status`
		arr=($res_status)
		# Recórrer totes les dades de status
		for i in ${!arr[@]}
		do
			if [ ${arr[$i]} == "VmSize:" ]
			then
				# echo ${arr[$i]} ${arr[$(($i+1))]}
				if [ $((${arr[$(($i+1))]})) -gt $((1024)) ]
				then
					echo "PID $1 ocupa més d'1 kB: ${arr[$(($i+1))]}"
				fi
			fi
		done
	fi
}

# Obtenir pids de l'usuari
if [ $# -eq $((0)) ]
then
	usr=`whoami`
else
	us=$1
fi
res_ps=`ps -u $usr -o pid`	
echo "Comprovant processos de l'usuari $usr"
for pid in $res_ps
do
	if [ $pid != "PID" ]
	then
		# Per cada PID, comprovar la seva mida
		checkmem $pid
	fi
done

while true
do
	echo -n "Escriu el PID del procés que vols eliminar: "
	read pid_p
	echo "Intentant eliminar el procés $pid_p..."
	kill -9 $pid_p
	err=$?
	if [ $err -eq $((0)) ]
	then
		echo "Procés eliminat exitosament"
	else
		echo "Error al eliminar el procés"
		echo "Codi d'error: $err"
	fi
done


