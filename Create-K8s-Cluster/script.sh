for i in `ls *.tf`
do
j="${i%.tf}"
mkdir $j
mv $i $j
done

