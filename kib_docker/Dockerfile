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

RUN useradd --create-home -s /bin/bash -u 3093 kibana

RUN cd /home/kibana && wget https://artifacts.elastic.co/downloads/kibana/kibana-6.2.3-linux-x86_64.tar.gz
RUN cd /home/kibana && tar zxf kibana-6.2.3-linux-x86_64.tar.gz
ENV KIBANA_HOME=/home/kibana/kibana-6.2.3-linux-x86_64
ENV PATH=$PATH:$KIBANA_HOME/bin

ADD src/init.sh /home/kibana/
RUN chmod +x /home/kibana/init.sh
RUN echo "server.host: "0.0.0.0"" >> /home/kibana/kibana-6.2.3-linux-x86_64/config/kibana.yml
RUN echo "elasticsearch.url: "http://es1.lexisnexis.cn:9200"" >> /home/kibana/kibana-6.2.3-linux-x86_64/config/kibana.yml
RUN echo "logging.quiet: true" >> /home/kibana/kibana-6.2.3-linux-x86_64/config/kibana.yml
RUN chown -R kibana:kibana /home/kibana

RUN cd /root/ && wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install supervisor
RUN mkdir -p /etc/supervisor/conf.d
ADD etc/supervisord.conf /etc/
ADD etc/supervisor/ntpdate.ini /etc/supervisor/conf.d/
ADD etc/supervisor/kibana.ini /etc/supervisor/conf.d/

RUN echo "session required /lib64/security/pam_limits.so" >> /etc/pam.d/login

EXPOSE 5601
WORKDIR /home/kibana
