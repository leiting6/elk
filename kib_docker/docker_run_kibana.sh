#!/usr/bin/env bash

docker run -it \
    --name elk-kib1 \
    -h elk-kib1 \
    --add-host "es1.XXX.cn:192.168.2.111" \
    --add-host "lgh1.XXX.cn:192.168.2.111" \
    --add-host "kib1.XXX.cn:192.168.2.111" \
    --privileged \
    --cap-add SYS_PTRACE \
    --restart=always \
    -e TZ=Asia/Hong_Kong \
    -d \
    -v /data/kibdata/kibana-6.2.4-linux-x86_64:/home/kibana/kibana-6.2.4-linux-x86_64 \
    -p 5601:5601 \
    reg.XXX.com.cn/lnc-devops/kibana6.2.4:latest \
    supervisord
