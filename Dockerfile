#FROM node:20.10.0-alpine3.18
FROM node:21.7.1-alpine3.19

LABEL maintainer="Vincent <alfa.king@gmail.com>"

RUN apk update && \
	apk add --no-cache --update zsh && \
	mkdir -p /start-script && \
    mkdir -p /root/app && \
    mkdir -p /root/.ssh && \
	apk add --no-cache --update vim git openssh curl procps tzdata bash && \
	echo "root:root" | chpasswd && \
    rm -rf /var/cache/apk/*

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
	sed -i 's/ash/zsh/g' /etc/passwd && \
	cd /root && \
	mkdir -p /run/sshd && \
	cd .ssh && \
	echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgs1Bgs8ocKNlsJnlGeJvCd4XDWzUbGKSfD5Bpqxyi09hAXzYhWG71xq1YZnwZgujpJzsPx7jGsyfRKrVD/9bLF8IYdnACYrMNbP4lifhX16R8VzCZTZL3Fofz9I2I8upii806ksmMBoMcDudq3ICZPcPnOHi8BdH3wo0qY1Z+K1e7nUYwEsOZqE85eD1LK0hgdxJ/fqd8e10x9O9FYs4k01PDIpyfxY594GqywLHIPOZoPYvQRd4mlWM1f7YtBit68dP1f+fqUUeAp0M/9YV2922i/AH86BIH24ytP75TOl2+rMxbYAa8mzpaLifO4ES76P/W1ncSihIK/fdVK+oexRdBEP4q6BxszYxvKpJui1LV83JPB/c6Hgl+qH1WlKg3Kkh9AGAJN/xkmFr/yJ2KYnSuTWu56uNZ5yYHCl0ZWgvHDPVgMS5abTOJG6eRvQ1ll/IFwcC1pBty/8tIAUTSdeeLVLCqIwMDK3WPnx6oxumo0lleVMzVXqTrbuH0dXc= wsl2" > authorized_keys && \
	echo "alias vi='vim'" >> /root/.zshrc && \
	ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
	rm -rf /var/cache/apk/*
	
RUN	ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key 
RUN	ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key 
RUN	ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key
RUN	ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key

ADD .vimrc /root/.vimrc
ADD .viminfo /root/.viminfo
ADD .vim /root/.vim

ENV TZ=Asia/Taipei

# 开放22端口
EXPOSE 22

# 执行ssh启动命令
CMD ["/usr/sbin/sshd", "-D"]
