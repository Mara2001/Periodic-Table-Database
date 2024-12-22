#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
fi

INPUT=$1
#echo $INPUT

# test zda je vstup cislo
if [[ $INPUT =~ [0-9]+ ]]
then
  #echo "Number"
  RESULT="$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number=$INPUT;")"  
# test zda je vztup znacka
elif [[ ${#INPUT} -le 2 ]]
then
  #echo "Symbol"
  RESULT="$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) WHERE symbol='$INPUT';")"
# vstup musi byt nazev
else
  #echo "Nazev"
  RESULT="$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) WHERE name='$INPUT';")"
fi
echo $RESULT