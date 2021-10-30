1. aws cloudshellを起動  

1. 初期設定を実施
    ```
    git clone https://github.com/kyuki-rp/portfolios-app.git
    sh $HOME/portfolios-app/build_tools/init_cloudshell/init_cloudshell.sh YourDomain.com
    ```

1. ecrにpush
    ```
    cd $HOME/portfolios-app/middenii
    terraform init -reconfigure -backend-config=backend_config.tfbackend
    terraform plan -var-file=$HOME/vars.tfvars -var-file=appname.tfvars
    terraform apply -var-file=$HOME/vars.tfvars -var-file=appname.tfvars --auto-approve
    terraform destroy -var-file=$HOME/vars.tfvars -var-file=appname.tfvars --auto-approve
    ```
