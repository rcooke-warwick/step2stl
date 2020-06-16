
#!/bin/sh -l

OIFS="$IFS"
IFS=$'\n'
for IN in `find $1 -iname "*.*"`
do
OUT=${IN/$1/$3}
DIR=$(dirname $OUT)
FILE_NAME="${IN##*/}"
FILE_EXTENSION="${FILE_NAME##*.}"
FILE_TYPE=".stl"
mkdir -p "$DIR"

echo "Converting $IN"
python convert-stl $IN ${OUT/$FILE_EXTENSION/$FILE_TYPE}


done
IFS="$OIFS"