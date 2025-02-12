rm -rf *pem*
rm -r join*sh
rm *.ini
terraform destroy --auto-approve            
rm *tfstate*
