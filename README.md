环境说明
1，OS: CentOS7,
2，ES Version:6.2.4
3，Logstash Version:6.2.4
4，Filebeat Version:6.2.4

安装方式
1，ES安装在容器中
2，Logstash安装在宿主机中（推荐安装到宿主机中,可支持读取多个配置文件）
3，Kibana安装在容器中
4，filebeat安装在需要收集日志的server中

运行方式
1，我的web server是centos5系统，因filebeat运行环境不支持redhat6和centos6之前的平台，所以nginx日志我输出到了nfs文件系统中
2，所有日志通过filebeat抓取，经过logstash过滤，存储到elasticsearch中，最后通过kibana搜索和展示各种数据图表
3，nginx日志输出到nfs中，filebeat收集的时候因存在nfs缓存的问题，kibana中展示出的日志信息中会有部分\u0000，可通过关闭缓存的方式解决
