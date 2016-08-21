##nginx配置文件

nginx配置文件主要分成四部分：main(全局设置)、http(HTTP的通用设置)、server(虚拟主机设置)、location(匹配URL路径)、event、upstream

###通用设置

1. user 指定运行nginx worker进程的用户和组
2. worker_rlimit_nofile 指定所有worker进程能够打开的最大文件数
3. worker_cpu_affinity 设置worker进程CPU粘性，以避免进程在CPU间切换带来的性能消耗
    worker_cpu_affinity 0001 0010 0100 1000 四核
4. worker_processes 4 worker工作进程的个数，这个值可以设置与CPU数量相同，如果开启了SSL和Gzip,那么可以适当增加此数值
5. worker_connections 100 单个worker进程接受的最大并发进程， 房子event段
6. error_log 错误日志的存放路径和记录级别
7. user epoll 使用epoll事件模型 放置event段中

###http服务器

1. listen 定义监听的地址和端口，默认监听本机所有地址
2. server_name NAME [...] 定义虚拟主机名，可以使用多个名称，还可以使用正则表达式或通配符
3. sendfile 开启sendfile调用来快速的相应客户端
4. keepalive_tiemout 长连接超时时间,单位秒
5. send_timeout 指定响应客户端的超时时间
6. client_max_body_size 允许客户端请求的实体最大大小
7. root 设置请求URL所对应资源所在文件系统上的目录
8. location [=|~|~*|^~] URI {...}
    设置一个URI匹配路径
    =：精确匹配
    ~：正则表达式匹配，区分字符大小写
    ~*：正则表达式匹配，不区分字符大小写
    ^~:URI的前半部分匹配，且不用正则表达式
    优先级：
    = > location 完整路径 > ^~ > ~ > ~* > location 起始路径 > location /
9. allow 和 deny
    基于IP访问控制
    仅允许192.168.0.0/24网段客户端访问
    allow 192.168.0.0/24;
    deny all;
10. stub_status 开启状态显示，仅用于location中
11. rewrite <REGEX> <REPLACE> <FLAG>
    可用的FLAG
    -last:重写完成后，继续匹配其他rewrite规则
    -break:重写完成后不在继续匹配
    -redirect:返回302重定向(临时重定向)，客户端对重定向的 URL 发起新的请求
    -permanent:返回301重定向(永久重定向)，客户端对重定向的 URL 发起新的请求


