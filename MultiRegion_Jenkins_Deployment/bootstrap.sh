# Installing Terraform,AWS CLI and ANSIBLE
echo "#########################################Installing Terraform#################################################"

wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

echo "#######################################Installing AWS CLIi ########################################################"

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -r awscliv2.zip
rm -r aws
terraform init


echo "########################################Installing ANSIBLE####################################################"

sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

echo "########################################Installing Boto3####################################################"

sudo apt install python3-pip -y
pip3 install boto3 --user
