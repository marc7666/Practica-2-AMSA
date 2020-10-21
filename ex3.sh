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
				if [ $((${arr[$(($i+1))]})) -gt $((1)) ]
				then
					echo "PID $1 ocupa més d'1 kB: ${arr[$(($i+1))]}"
				fi
			fi
		done
	fi
}


# Obtenir pids de l'usuari
res_ps=`ps -u joel -o pid`
for pid in $res_ps
do
	if [ $pid != "PID" ]
	then
		# Per cada PID, comprovar la seva mida
		checkmem $pid
	fi
done


