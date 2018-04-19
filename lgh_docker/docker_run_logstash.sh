#!/usr/bin/env bash

docker run -it \
    --name elk_lgh1 \
    -h elk_lgh1 \
    --privileged=true \
    --cap-add SYS_PTRACE \
    --init \
    --restart=always \
    --add-host "es1.XX.cn:192.168.2.111" \
    --add-host "lgh1.XX.cn:192.168.2.111" \
    --add-host "kib1.XX.cn:192.168.2.111" \
    -e TZ=Asia/Hong_Kong \
    -d \
    -v /data/lghdata:/home/lghdata/logstash-6.2.3/data \
    -v /data/lghlogs:/home/lghdata/logstash-6.2.3/logs \
    -p 5044:5044 \
    -p 9600:9600 \
    logstash6.2.3/prd:v1.0 \
    supervisord
