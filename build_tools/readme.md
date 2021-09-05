1. aws cloudshellを起動  

1. 初期設定を実施
    ```
    git clone https://github.com/kyuki-rp/portfolios-app.git
    sh $HOME/portfolios-app/build_tools/init_cloudshell/init_cloudshell.sh
    ```

1. ecrにpush
    ```
    cd $HOME/portfolios-app/build_tools/push_ecr
    terraform init
    terraform plan -var 'app_name=poto'
    terraform apply -var 'app_name=poto' --auto-approve
    ```

1. ecsにbuild
    ```
    cd $HOME/portfolios-app/build_tools/build_ecs
    terraform init
    terraform plan -var 'app_name=poto' -var 'app_name=poto'
    terraform apply  -var 'app_name=poto' --auto-approve
    ```

1. 