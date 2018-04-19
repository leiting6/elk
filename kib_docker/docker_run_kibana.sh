#!/usr/bin/env bash

docker run -it \
    --name elk_kib1 \
    -h elk_kib1 \
    --add-host "es1.XX.cn:192.168.2.111" \
    --add-host "lgh1.XX.cn:192.168.2.111" \
    --add-host "kib1.XX.cn:192.168.2.111" \
    --privileged \
    --cap-add SYS_PTRACE \
    --restart=always \
    -e TZ=Asia/Hong_Kong \
    -d \
    -v /data/kibdata:/home/kibana/kibana-6.2.3-linux-x86_64/data \
    -p 5601:5601 \
    kibana6.2.3/prd:v1.0 \
    supervisord
