
GetFileSize()
{
    echo "$(ls -la $1 | awk '{ print $5}')"
} 
partSize=16777216
fileSize=$(GetFileSize $1) 
partsCount=$((fileSize/partSize))
remainingBytes=$((fileSize%partSize))

take=$((partSize/4096))
partIndex=0
while [ $partIndex -lt $partsCount ]
do
    echo $partIndex
    skip=
    dd if=$1 bs=4096 count=$take skip=$((partIndex*take)) 2>dump |  nc 127.0.0.1 9012
    #echo $partIndex |  nc 127.0.0.1 9012 -w 10
    partIndex=$((partIndex+1))
    sleep .1
done
if [ $remainingBytes -gt 0 ]
then
    echo "remaining bytes" 
    dd if=$1 ibs=1 count=$remainingBytes skip=$((partIndex*partSize)) 2>dump |  nc 127.0.0.1 9012
    partIndex=$((partIndex+1))
    sleep .1

fi