# terraformインストール
wget https://releases.hashicorp.com/terraform/0.14.2/terraform_0.14.2_linux_amd64.zip
sudo unzip terraform_0.14.2_linux_amd64.zip -d /usr/local/bin/
rm -r terraform_0.14.2_linux_amd64.zip
terraform --version