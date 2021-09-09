# terraformインストール
wget https://releases.hashicorp.com/terraform/0.14.2/terraform_0.14.2_linux_amd64.zip
sudo unzip terraform_0.14.2_linux_amd64.zip -d /usr/local/bin/
rm -r terraform_0.14.2_linux_amd64.zip
terraform --version

# vars.tfvars作成
UserId=`aws sts get-caller-identity | jq '.UserId'`
Account=`aws sts get-caller-identity | jq '.Account'`
Arn=`aws sts get-caller-identity | jq '.Arn'`
AppName=poto
touch vars.tfvars
echo "aws_user_id=$UserId" >> vars.tfvars
echo "aws_account_id=$Account" >> vars.tfvars
echo "aws_arn=$Arn" >> vars.tfvars
echo "app_name=$AppName" >> vars.tfvars