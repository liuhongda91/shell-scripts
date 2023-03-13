curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

systemctl start docker.service
systemctl enable docker.service

docker pull hwdsl2/ipsec-vpn-server

docker run --restart always --name ipsec-vpn-server -e VPN_IPSEC_PSK=aa123456 -e VPN_USER=user -e VPN_PASSWORD=aa123456 -p 500:500/udp -p 4500:4500/udp -d --privileged hwdsl2/ipsec-vpn-server

sudo modprobe af_key

firewall-cmd --permanent --add-service="ipsec"
firewall-cmd --permanent --add-port=4500/udp
firewall-cmd --permanent --add-masquerade
firewall-cmd --reload
