# Practica-2-AMSA
```
1a. ls -l /proc/$1/fd
1b. $1
ls -l /proc/$1/fd | wc -l
while IFS= read -r line
do
  echo "$line"
done < fitxer
```
