# terraformインストール
wget https://releases.hashicorp.com/terraform/0.14.2/terraform_0.14.2_linux_amd64.zip
sudo unzip terraform_0.14.2_linux_amd64.zip -d /usr/local/bin/
rm -r terraform_0.14.2_linux_amd64.zip
terraform --version

# vars.tfvars作成
rm vars.tfvars
UserId=`aws sts get-caller-identity | jq '.UserId'`
Account=`aws sts get-caller-identity | jq '.Account'`
Arn=`aws sts get-caller-identity | jq '.Arn'`
rm vars.tfvars -f
touch vars.tfvars
echo "aws_user_id=$UserId" >> vars.tfvars
echo "aws_account_id=$Account" >> vars.tfvars
echo "aws_arn=$Arn" >> vars.tfvars
echo 'tfstate_s3bucketname="tfstate-u5n1k2x1"' >> vars.tfvars
echo 'app_name="poto"' >> vars.tfvars