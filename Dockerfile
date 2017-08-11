# 
# Arquivo para criação de banco de dados MySQL
#

FROM debian

ENV FTP_USER dev 
ENV FTP_PASSWORD dev 
ENV FTP_UID 1000 
ENV FTP_GID 1000 
#ENV FTP_PATH /data/ftp/

RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends vsftpd openssl ssl-cert && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY vsftpd.conf /etc/vsftpd.conf
COPY start.sh /

RUN chmod +x /start.sh

EXPOSE 20
EXPOSE 21
#EXPOSE 12020
#EXPOSE 12021
#EXPOSE 12022
#EXPOSE 12023
#EXPOSE 12024
#EXPOSE 12025

ENTRYPOINT ["/start.sh"]
