#!/bin/bash
FICHERO_TEMP=`mktemp`

NOMBRE_ISO=principe-persia1.iso
read -p "Nombre del ficheor de salida .iso ? : " NOMBRE_ISO


## ver datos del DVD
isoinfo -d -i /dev/sr0 |grep -i -E 'block size|volume size' >${FICHERO_TEMP}


BLOQUE_SIZE=$(cat ${FICHERO_TEMP} |grep -i 'block'|cut -d: -f 2)

BLOQUE_SIZE=`echo ${BLOQUE_SIZE} | sed 's/ *s//g'`



VOLUMEN_SIZE=$(cat ${FICHERO_TEMP} |grep -i 'volume'|cut -d: -f 2)


VOLUMEN_SIZE=`echo ${VOLUMEN_SIZE} |sed 's/ *S//g'`



echo "BLOQUE SIZE: +${BLOQUE_SIZE}+"
echo "VOLUMEN SIZE: +${VOLUMEN_SIZE}+"
echo "Preparando el fichero ${NOMBRE_ISO}..."

## pasar a iso
COMANDO="dd if=/dev/sr0 of=${NOMBRE_ISO} bs=${BLOQUE_SIZE} count=${VOLUMEN_SIZE} status=progress "
echo Ejecucion:
echo ${COMANDO}
${COMANDO}




