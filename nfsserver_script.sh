#Install NFS utils
yum install nfs-utils

#add firewall rules
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --add-service="nfs3" --add-service="rpc-bind" --add-service="mountd" --permanent
firewall-cmd --reload

#enable NFS server
systemctl enable nfs --now

#create directory
mkdir -p /srv/share/nfs
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/nfs

cat <<EOF>> /etc/exports
/srv/share 192.168.50.11/32(rw,sync,root_squash)
EOF
exportfs -r

#Create check file
touch /srv/share/nfs/server_file_check
