FROM alpine:latest
RUN apk update && \
    apk add py-pip && \
    pip install shadowsocks

# 这里应该使用容器的ip 172.17.0.2
ENV SERVER_HOST=172.17.0.2 \
    SERVER_PORT=6550 \
    BROSWER_PORT=6551 \
    SERVER_PASSWORD=uljshdcULJSHDCty \
    SERVER_METHOD='rc4-md5'

# 修改源文件
# openssl升级到1.1.0版本后，shadowsocks2.8.2版本不对应
# https://blog.csdn.net/shelldawn/article/details/83578218
RUN rm /usr/lib/python2.7/site-packages/shadowsocks/crypto/openssl.py

ADD openssl.py /usr/lib/python2.7/site-packages/shadowsocks/crypto/

VOLUME /data/shadowsocks

ADD shadowsocks.config.sh /bin/

CMD ssserver -c /data/shadowsocks/server.json -d start && sslocal -c /data/shadowsocks/broswer.json start

ENTRYPOINT ["/bin/shadowsocks.config.sh"]

EXPOSE 6550
EXPOSE 6551

# docker run --rm --name sss1 -p 6551:6551 -p 6550:6550 shadowsocks:v1.0.0