FROM centos:7.4.1708
MAINTAINER "leiting.liu@lexisnexis.com leiting.liu@qq.com"

ENV TZ=Asia/Hong_Kong
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN yum install -y \
        telnet \
        vim \
        net-tools \
        ntpdate \
        ntp \
        curl \
        psmisc \
        wget \
        unzip \
        sendmail \
        mail \
        crontabs

#RUN systemctl enable sendmail
#RUN systemctl enable crond

RUN useradd --create-home -s /bin/bash -u 3092 es

COPY src/jdk-8u161-linux-x64.tar.gz /home/es/
RUN cd /home/es && tar zxf jdk-8u161-linux-x64.tar.gz
ENV JAVA_HOME=/home/es/jdk1.8.0_161
ENV PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

RUN cd /home/es && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.3.zip
RUN cd /home/es && unzip elasticsearch-6.2.3.zip

ADD src/init.sh /home/es/
RUN chmod +x /home/es/init.sh
RUN echo 'network.host: 0.0.0.0' >> /home/es/elasticsearch-6.2.3/config/elasticsearch.yml
RUN chown -R es:es /home/es

RUN cd /root/ && wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install supervisor
RUN mkdir -p /etc/supervisor/conf.d
ADD etc/supervisord.conf /etc/
ADD etc/supervisor/ntpdate.ini /etc/supervisor/conf.d/
ADD etc/supervisor/elasticsearch.ini /etc/supervisor/conf.d/

RUN echo "vm.max_map_count = 262144" >> /etc/sysctl.conf
RUN echo "es soft nofile 65536" >> /etc/security/limits.conf
RUN echo "es hard nofile 65536" >> /etc/security/limits.conf
RUN echo "es soft nproc 2048" >> /etc/security/limits.d/90-nproc.conf
RUN echo "bootstrap.memory_lock: false" >> /home/es/elasticsearch-6.2.3/config/elasticsearch.yml
RUN echo "bootstrap.system_call_filter: false" >> /home/es/elasticsearch-6.2.3/config/elasticsearch.yml
RUN echo "cluster.routing.allocation.disk.threshold_enabled: false" >> /home/es/elasticsearch-6.2.4/config/elasticsearch.yml
ENV vm.max_map_count = 262144

RUN echo "session required /lib64/security/pam_limits.so" >> /etc/pam.d/login
RUN echo "net.ipv4.ip_local_port_range = 1024 65000" >> /etc/sysctl.conf

EXPOSE 9200 9201 9301
WORKDIR /home/es
