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
#echo $RESULT | sed 's/|/ /g' | read ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELTING BOILING TYPE_ID
echo $RESULT | while IFS='|' read ATOMIC_NUMBER SYMBOL NAME TYPE MASS MELTING BOILING TYPE_ID
do
# The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
done