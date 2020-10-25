echo "Fallades de pàgina al sistema des del seu inici: "
echo `cat /proc/vmstat | grep pgfault`
