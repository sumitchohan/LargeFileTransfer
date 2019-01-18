loopIndex=0
while [  "1" = "1" ]
do
    echo "Listening - $loopIndex"
    nc -l 9012 > received$loopIndex.data
    loopIndex=$((loopIndex+1))
done