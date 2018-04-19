#!/usr/bin/env bash

docker run -it \
    --name elk_es1 \
    -h elk_es1 \
    --privileged \
    --cap-add SYS_PTRACE \
    --restart=always \
    -e TZ=Asia/Hong_Kong \
    -d \
    --add-host "es1.lexisnexis.cn:192.168.2.111" \
    --add-host "lgh1.lexisnexis.cn:192.168.2.111" \
    --add-host "kib1.lexisnexis.cn:192.168.2.111" \
    --ulimit nofile=65536:65536 \
    --ulimit nproc=4096:4096 \
    -v /data/esdata:/home/es/elasticsearch-6.2.3/data \
    -v /data/eslogs:/home/es/elasticsearch-6.2.3/logs \
    -p 9200:9200 \
    -p 9201:9201 \
    -p 9301:9301 \
    elasticsearch6.2.3/prd:v1.0 \
    supervisord
