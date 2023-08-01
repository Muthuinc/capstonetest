#! /bin/bash
 set -e
export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

pwd


terraform init && terraform apply --auto-approve

echo "success"

a=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Env,Values=prod" --query 'Reservations[].Instances[].PublicIpAddress' --output text)

export psw1="$1"

scp -o StrictHostKeyChecking=no -i "$psw1" docker-compose.yml ubuntu@$a

ssh -o StrictHostKeyChecking=no -i "$psw1" ubuntu@$a <<EOF

pwd 

ls

sudo apt update -y 

sudo apt install -y docker.io

sudo apt install -y docker-compose

sudo docker-compose up -d

if curl localhost:80
then
  echo "success"
fi

EOF

