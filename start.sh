#!/bin/bash

# 启动 sshd 服务
/usr/sbin/sshd -D &

# 启动用户自定义脚本
/root/app/start_frp.sh &

# 等待所有后台进程
wait
