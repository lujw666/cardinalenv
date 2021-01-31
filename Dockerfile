FROM debian:10
#安装miniconda
RUN apt-get update --fix-missing -y &&  \
	apt-get upgrade -y &&  \
	apt-get install -y --fix-missing wget bzip2 \
	ca-certificates  libglib2.0-0 libxext6 \
	libsm6 libxrender1 libgl1  git mercurial \
	subversion  curl grep sed dpkg vim &&  \
	wget --quiet https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh -O ~/anaconda.sh &&  \
	/bin/bash ~/anaconda.sh -b -p /opt/conda &&  \
	rm ~/anaconda.sh &&  \
	ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh &&  \
	echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc &&  \
	echo "conda activate base" >> ~/.bashrc &&  \
	apt-get clean 
#添加conda路径
ENV PATH /opt/conda/bin:$PATH
#安装R,python相关库及包
RUN conda update conda &&  \
	conda config --add channels conda-forge &&  \
	conda config --add channels r &&  \
	conda config --add channels bioconda &&  \
	conda install -y r-base==4.0.3 &&  \
	conda install -y bioconductor-cardinal  &&  \
	mkdir data &&  \
	chmod 777 data &&  \
	conda clean -y --all
#安装studio-server
RUN	apt-get update -y && \
	apt-get install -y gdebi-core && \
	wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.5033-amd64.deb  && \
	gdebi --non-interactive rstudio-server-1.2.5033-amd64.deb  && \
	rm -rf rstudio-server-1.2.5033-amd64.deb && \
	echo "rsession-which-r=/opt/conda/bin/R" >> /etc/rstudio/rserver.conf  && \
	echo "www-port=8787" >> /etc/rstudio/rserver.conf && \
	rm -rf /etc/rstudio/rsession.conf && \
	apt-get clean
#utf-8支持并修改root登录密码
RUN apt-get -yq install openssh-server && \
	mkdir /var/run/sshd && \
	echo 'root:lumingbio' | chpasswd && \
	sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
	echo "export VISIBLE=now" >> /etc/profile && \
	echo "PATH=/opt/conda/bin:$PATH" >> /etc/profile && \
	echo "export PATH" >> /etc/profile && \
	echo "export LANG=zh_CN.utf8" >> /etc/profile && \
	apt-get clean
#部分R包功能修复
RUN apt-get update -y && \
	apt-get install -y libnetcdf-dev && \
	cp /opt/conda/lib/R/modules/lapack.so /opt/conda/lib/R/modules/libRlapack.so && \
	cp /opt/conda/lib/R/modules/libRlapack.so /opt/conda/lib/libRlapack.so && \
	apt-get clean
#安装pandoc
RUN apt-get install -y pandoc hub git-flow zip && \
	apt-get clean
ADD file/ /data/
RUN	bash /data/user  &&  \
	rm -rf /data/* &&  \
	cd /home
CMD ["/usr/sbin/sshd", "-D"]
