i=`cat -`
result=`echo "scale=3; $i/10" | bc`
#echo $result

comp1=`echo "$result < 0.125" | bc -l`
comp2=`echo "$result < 0.375" | bc -l`
comp3=`echo "$result < 0.625" | bc -l`
comp4=`echo "$result < 0.875" | bc -l`


#echo $comp1
if [ $comp1 -eq 1 ]; then
echo 0.00
elif [ $comp2 -eq 1 ]; then
echo 0.25
elif [ $comp3 -eq 1 ]; then
echo 0.5
elif [ $comp4 -eq 1 ]; then
echo 0.75
else
echo 1
fi
