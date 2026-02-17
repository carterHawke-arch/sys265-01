#secure-ssh.sh
#author carter
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in
username=$1

sudo useradd -m -d /home/$username -s /bin/bash $username
sudo mkdir -p /home/$username/.ssh
sudo chmod 700 /home/$username/.ssh
cd /home/carter/sys265-01
sudo cp sys265-01/linux/public-keys/id_rsa.pub /home/$username/.ssh/authorized_keys
sudo chmod 600 /home/$username/.ssh/authorized_keys
sudo chown -R $username:$username /home/$username/.ssh

sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

sudo systemctl restart sshd.service

echo "Configuration complete"
echo "Root SSH login disabled"
echo "User $username can now login with SSH key authentication"
