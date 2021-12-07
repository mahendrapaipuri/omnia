#! /bin/bash

# Variables
USER="root"
G5K_PASSWORD="grid5000"
hostfile="nodelist"

# Install dependencies
yum install epel-release -y
yum install ansible git -y
yum install sshpass -y
yum install python-netaddr -y

# Add StrictHostKeyChecking in ssh/config
echo "Host *" > /$USER/.ssh/config
echo "  StrictHostKeyChecking no" >> /$USER/.ssh/config

# Get list of servers
NODES=`cat $hostfile`

# Copy generated keys to all
count=1
for NODE in $NODES
do
  if [[ $count == 1 ]]; then
    ssh-keygen -t rsa -N "" -f /$USER/.ssh/id_rsa
  else
    sshpass -p "$G5K_PASSWORD" ssh-copy-id -o StrictHostKeyChecking=no \
      -i /$USER/.ssh/id_rsa $USER@$NODE
  fi
  ssh $NODE yum install python2 -y
  count=$((count+1))
done

# # Generate hostfile for ansible
count=1
for NODE in $NODES
do
  if [[ $count > 1 ]]; then
    if [[ $count == 2 ]]; then
      echo "[manager]" > hostfile
      echo "$NODE" >> hostfile
      echo "[login]" >> hostfile
      echo "$NODE" >> hostfile
      echo "[nfs]" >> hostfile
      echo "$NODE" >> hostfile
    else
      if [[ $count == 3 ]]; then
        echo "[compute]" >> hostfile
      fi
      echo "$NODE" >> hostfile
    fi
  fi
  count=$((count+1))
done

# # Change directory to /home/omnia -> Here is where we copy ansible roles
# cd /home/omn
