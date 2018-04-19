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
RUN systemctl enable crond

RUN useradd --create-home -s /bin/bash -u 3094 logstash

COPY src/jdk-8u161-linux-x64.tar.gz /home/logstash/
RUN cd /home/logstash && tar zxf jdk-8u161-linux-x64.tar.gz
ENV JAVA_HOME=/home/logstash/jdk1.8.0_161
ENV PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

RUN cd /home/logstash && wget https://artifacts.elastic.co/downloads/logstash/logstash-6.2.3.tar.gz
RUN cd /home/logstash && tar zxf logstash-6.2.3.tar.gz
RUN echo "http.host: "0.0.0.0""  >> /home/logstash/logstash-6.2.3/config/logstash.yml
ADD src/logstash-filebeat.yml /home/logstash/logstash-6.2.3/config/

ADD src/init.sh /home/logstash/
RUN chmod +x /home/logstash/init.sh
RUN chown -R logstash:logstash /home/logstash

RUN cd /home/logstash && wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install supervisor
RUN mkdir -p /etc/supervisor/conf.d
ADD etc/supervisord.conf /etc/
ADD etc/supervisor/ntpdate.ini /etc/supervisor/conf.d/
ADD etc/supervisor/logstash.ini /etc/supervisor/conf.d/

RUN echo "session required /lib64/security/pam_limits.so" >> /etc/pam.d/login

EXPOSE 5044 9600
WORKDIR /home/logstash
