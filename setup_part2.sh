cd ~

./snowgem-cli stop

echo "wait for 200 seconds"
x=1
while [ $x -le 200 ]
do
  echo "$x"
  sleep 1
  x=$(( $x + 1 ))
done

./snowgem-cli masternodedebug
