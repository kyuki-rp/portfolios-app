# terraformインストール
wget https://releases.hashicorp.com/terraform/0.14.2/terraform_0.14.2_linux_amd64.zip
sudo unzip terraform_0.14.2_linux_amd64.zip -d /usr/local/bin/
rm -r terraform_0.14.2_linux_amd64.zip
terraform --version

# tfvarsの設定
rm vars.tfvars
UserId=`aws sts get-caller-identity | jq '.UserId'`
Account=`aws sts get-caller-identity | jq '.Account'`
Arn=`aws sts get-caller-identity | jq '.Arn'`
S3Bucket='"tfstate-u5n1k2x1"'
DomainName1=\"${DomainName}.\"
DomainName2=\"${DomainName}\"
HostZoneId=`aws route53 list-hosted-zones --output json | jq -r ".HostedZones[] | select(.Name == $DomainName1) | .Id"`
HostZoneId=\"${HostZoneId#\/hostedzone\/}\"
rm vars.tfvars -f
touch vars.tfvars
echo "aws_user_id=$UserId" >> vars.tfvars
echo "aws_account_id=$Account" >> vars.tfvars
echo "aws_arn=$Arn" >> vars.tfvars
echo "tfstate_s3bucketname=$S3Bucket" >> vars.tfvars
echo "hostzone_id=$HostZoneId" >> vars.tfvars
echo "domain_name=$DomainName2" >> vars.tfvars

# tfbackendの設定
grep -lr --include="backend_config.tfbackend" "" ./* | xargs sed -i.bak -e "s/BucketName/$S3Bucket/g"
