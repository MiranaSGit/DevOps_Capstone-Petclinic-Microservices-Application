PATH="$PATH:/usr/local/bin"
APP_NAME="petclinic"
envsubst < docker-compose-swarm-dev.yml > docker-compose-swarm-dev-tagged.yml # jenkins srver üzerindeki değişkenleri swarm grand-manager'a göndermek için envsubst kullanarak yeni bir dosya oluşturup, swarm deploy için o dosyayı kullanıyoruz.
ansible-playbook -i ./ansible/inventory/dev_stack_dynamic_inventory_aws_ec2.yaml -b --extra-vars "workspace=${WORKSPACE} app_name=${APP_NAME} aws_region=${AWS_REGION} ecr_registry=${ECR_REGISTRY}" ./ansible/playbooks/pb_deploy_app_on_docker_swarm.yaml