#!/bin/bash
sudo apt-get update
sudo apt install -y docker.io
sudo apt-get install -y git

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo systemctl start docker
sudo systemctl enable docker

git clone -b point7 --single-branch https://FKryleckiSE:glpat-Qj-yoJjFz_hUKKZ_Sek_@gitlab.com/saxion.nl/hbo-ict/2.3-devops/2023-2024/exam-retake/03.git
cd 03

cat <<'EOF' > fetch_ip.sh
#!/bin/bash
INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "Instance IP: $INSTANCE_IP"
export INSTANCE_IP=$INSTANCE_IP
EOF
sudo chmod +x fetch_ip.sh
source fetch_ip.sh
echo "INSTANCE_IP=$INSTANCE_IP" > .env

sudo docker-compose up -d
