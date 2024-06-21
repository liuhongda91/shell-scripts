yum install wget -y
#wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
#python get-pip.py
#pip install shadowsocks
#wget https://raw.githubusercontent.com/liuhongda91/shell-scripts/main/shadowsocks.json
#firewall-cmd --zone=public --add-port=8388/tcp --permanent
#firewall-cmd --reload
#nohup ssserver -c shadowsocks.json >>  ss.log 2>&1 &
#sudo ssserver -p 443 -k password -m aes-256-cfb --user nobody -d start

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
