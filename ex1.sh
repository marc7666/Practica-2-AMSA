#!/bin/bash
if [ "$#" -eq 1 ] #Tenim 1 paràmetre
then
	sudo ls -la /proc/$1/fd
fi
if [ "$#" -eq 0 ] #No tenim paràmetres
then
	echo Pid: nombre de fitxers oberts: Mida memòria virtual: Mida memòria resident:
	pids=$ls /proc | grep [0-9] #Dintre del fitxer /proc busquem aquells fitxers que tenen un nombre per nom, és a dir, els pids
	echo "Pid : Nombre fitxers oberts: mida Memòria Virtual : mida Memòria Resident"
	let "i=0"
	let "x=1"
	cd /proc
	#per llistar nomes els directoris hauriem de fer "ls -d [0-9]*/" 
	#pero ens aprofitem que nomes hi hauran carpetes amb numeros
	pid=($(ls -d [0-9]*))
        while [ $i -lt ${#pid[@]} ]
        do
	  cd /proc/${pid[$i]}/fd
	  fileNumber=$(ls | wc -l)
	  cd ..
	  virtualMemmory=($(grep VmSize status))
	  residentMemmory=($(grep VmRSS status))
	  echo "${pids[$i]} : $fileNumber : ${virtualMemmory[1]} kb : ${residentMemmory[1]} kb"
		cd ..
		let i=i+x
	done
	exit 0
fi

