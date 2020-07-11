FROM    seffeng/alpine:latest

MAINTAINER seffeng "seffeng@sina.cn"

ARG BASE_DIR="/opt/websrv"

ENV XUNSEARCH_VERSION=xunsearch-full-latest\
 INSTALL_DIR=${BASE_DIR}/program/xunsearch\
 DATA_DIR=${BASE_DIR}/data/xunsearch\
 EXTEND="gcc g++ make zlib-dev supervisor"

ENV XUNSEARCH_URL="http://www.xunsearch.com/download/${XUNSEARCH_VERSION}.tar.bz2"

WORKDIR /tmp
COPY conf ./conf

RUN apk update && apk add ${EXTEND} &&\
 wget ${XUNSEARCH_URL} &&\
 mkdir -p ${DATA_DIR} ${BASE_DIR}/logs ${BASE_DIR}/tmp &&\
 mkdir -p /etc/supervisor.d/ && cp -Rf /tmp/conf/supervisor/* /etc/supervisor.d/ &&\
 tar -jxf ${XUNSEARCH_VERSION}.tar.bz2 &&\
 xs_dir=$(ls -F | grep xunsearch | grep "/$" | awk '{print $1; exit}') &&\
 echo "${xs_dir}" &&\
 cd "${xs_dir}" &&\
 sh setup.sh --prefix=${INSTALL_DIR} &&\
 ln -s ${INSTALL_DIR}/bin/xs-ctl.sh /usr/bin/xs-ctl &&\
 rm -rf ${INSTALL_DIR}/data &&\
 ln -s ${DATA_DIR} ${INSTALL_DIR}/data &&\
 sed -i 's/;nodaemon=false/nodaemon=true/' /etc/supervisord.conf &&\
 rm -rf /var/cache/apk/* &&\
 rm -rf /tmp/*

VOLUME ["${DATA_DIR}", "${BASE_DIR}/logs", "${BASE_DIR}/tmp"]

EXPOSE 8383 8384
CMD ["supervisord", "-c", "/etc/supervisord.conf"]