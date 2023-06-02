FROM node:18.16.0-bullseye

LABEL maintainer="Vincent <alfa.king@gmail.com>"

RUN apt update && \
	apt -y -q install vim && \
	apt -y -q install git && \
	apt -y -q install curl && \
	apt -y -q install zsh && \
	apt -y -q install openssh-server && \ 
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
	ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key && \
	ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
# 	ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
# 	ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key && \
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
	echo "root:admin" | chpasswd && \
	# sed -i 's/ash/zsh/g' /etc/passwd && \
	cd /root && \
	mkdir .ssh && \
	mkdir app && \
	cd .ssh && \
	echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgs1Bgs8ocKNlsJnlGeJvCd4XDWzUbGKSfD5Bpqxyi09hAXzYhWG71xq1YZnwZgujpJzsPx7jGsyfRKrVD/9bLF8IYdnACYrMNbP4lifhX16R8VzCZTZL3Fofz9I2I8upii806ksmMBoMcDudq3ICZPcPnOHi8BdH3wo0qY1Z+K1e7nUYwEsOZqE85eD1LK0hgdxJ/fqd8e10x9O9FYs4k01PDIpyfxY594GqywLHIPOZoPYvQRd4mlWM1f7YtBit68dP1f+fqUUeAp0M/9YV2922i/AH86BIH24ytP75TOl2+rMxbYAa8mzpaLifO4ES76P/W1ncSihIK/fdVK+oexRdBEP4q6BxszYxvKpJui1LV83JPB/c6Hgl+qH1WlKg3Kkh9AGAJN/xkmFr/yJ2KYnSuTWu56uNZ5yYHCl0ZWgvHDPVgMS5abTOJG6eRvQ1ll/IFwcC1pBty/8tIAUTSdeeLVLCqIwMDK3WPnx6oxumo0lleVMzVXqTrbuH0dXc= wsl2" > authorized_keys && \
	echo "alias vi='vim'" >> /root/.zshrc && \
	apt clean && apt autoclean && apt autoremove && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD .vimrc /root/.vimrc
ADD .viminfo /root/.viminfo
ADD .vim /root/.vim

# 开放22端口
EXPOSE 22

# 执行ssh启动命令
CMD ["/usr/sbin/sshd", "-D"]
