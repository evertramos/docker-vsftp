#!/bin/bash

if [ -z "$FTP_USER" ]; then
    FTP_USER=dev
fi

if [ -z "$FTP_PASSWORD" ]; then
    FTP_PASSWORD=dev
fi

if [ -z "$FTP_GID" ]; then
    FTP_GID=1000
fi

if [ -z "$FTP_UID" ]; then
    FTP_UID=1000
fi

echo "Creating group 'VSFTP' with ID $FTP_GID"
groupadd -g $FTP_GID vsftp || echo 'Grupo já existente'

echo "Creating user '$FTP_USER' with ID $FTP_UID"
#useradd -m -g $FTP_GID -p $FTP_PASSWORD -u $FTP_UID $FTP_USER || echo 'Usuário já existete'
useradd -m -g $FTP_GID -p $(echo $FTP_PASSWORD | openssl passwd -1 -stdin) -u $FTP_UID $FTP_USER || echo 'Usuário já existete'
#useradd -m -g $FTP_GID -p $(perl -e 'print crypt($FTP_PASSWORD, md5)') -u $FTP_UID $FTP_USER || echo 'Usuário já existete'
#useradd -m -g $FTP_GID -u $FTP_UID $FTP_USER || echo 'Usuário já existete'
#echo $FTP_PASSWORD | passwd $FTP_USER --stdin

echo "Create empty folder"
[ ! -d /var/run/vsftpd/empty ] && mkdir -p /var/run/vsftpd/empty
#mkdir /var/run/vsftpd/empty || echo '.'

echo "Lauching vsftp server..."
vsftpd

