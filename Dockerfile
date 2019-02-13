FROM jare/emacs

ARG WORKSPACE_ARG
ENV WORKSPACE=${WORKSPACE_ARG}
ENV libroot /opt/ciao



# Update packages for ubuntu:lastest
RUN apt-get -y update > /dev/null 2>&1 && \
    apt-get -y install curl gcc git \
    > /dev/null 2>&1

# Download ciao prolog
RUN cd /home/emacs/ && git clone https://github.com/ciao-lang/ciao.git
RUN cd /home/emacs/ciao && ./ciao-boot.sh get devenv

# Configure ciao

RUN export PATH=$PATH:~/ciao/build/bin

# Emacs
COPY addTo_emacs /home/emacs/addTo_emacs
RUN mkdir -p /home/emacs/.emacs.d/ && \
    touch /home/emacs/.emacs.d/init.el && \
    cat /home/emacs/addTo_emacs >> /home/emacs/.emacs.d/init.el && \
    echo "(setq default-directory \"${WORKSPACE}\")" >> /home/emacs/.emacs.d/init.el && \
    rm /home/emacs/addTo_emacs

# Clean
RUN apt-get clean && \
    apt-get -y autoremove
