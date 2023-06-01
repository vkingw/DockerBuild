FROM node:18-alpine 

LABEL maintainer="vincent <alfa.king+git@gmail.com>"
LABEL description="nodejs 18 alpine"

RUN  apk update && \ 
	apk add --no-cache openssh tzdata zsh git curl && \ 
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
	ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key && \
	ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
	ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
	ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key && \
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
	echo "root:admin" | chpasswd

# 开放22端口
EXPOSE 22

# 执行ssh启动命令
CMD ["/usr/sbin/sshd", "-D"]
