export IP=`sed 's/master1/master/g;s/worker-1/worker-/g' ansible_inventory.ini  | grep $1  | awk -F"=" '{print $2}'`
export USER=`grep -i ansible_user ansible_inventory.ini | awk -F"=" '{print $2}'`
export KEY=`grep -i key_file ansible_inventory.ini | awk -F"./" '{print $2}'`
export PROXY=`grep -i ansible_ssh_common_args ansible_inventory.ini | awk -F"='" '{print $2}' | sed "s/'$//"`
#echo "IP= "$IP
#echo "USER= "$USER
#echo "KEY= "$KEY
#echo "PROXY= "$PROXY

Login="ssh $PROXY -i ./$KEY $USER@$IP"
ssh -vvv $PROXY -i ./$KEY $USER@$IP
#echo $Login

#cmd=("-o ProxyCommand='ssh $bastion -W %h:%p' -A -D $port $user@$host")
#echo "Executing --> $cmd"
#eval "ssh ${cmd[@]}"
eval "$Login"

