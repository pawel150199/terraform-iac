## This directory provides simple infrastracture for linux administration labs

To start infrastructure type these commands:

* `terraform init` -> to init needed things to provide infra
  
* `terraform plan -var='hcloud_token=<your_token>'` -> to plan resources
  
* `terraform apply -var='hcloud_token=<your_token>'` -> apply resources and create them in provider
  
* `terraform destroy-var='hcloud_token=<your_token>'` -> destroy created resources