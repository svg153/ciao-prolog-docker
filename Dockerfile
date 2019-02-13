FROM jare/emacs

ARG WORKSPACE_ARG
ENV WORKSPACE=${WORKSPACE_ARG}

# Update packages for ubuntu:lastest
RUN apt-get -y update > /dev/null 2>&1 && \
    apt-get -y install curl gcc git \
    > /dev/null 2>&1

# Download ciao prolog
RUN git clone https://github.com/ciao-lang/ciao.git /home/emacs/
RUN /home/emacs/ciao-boot.sh get devenv > /dev/null 2>&1

# Configure ciao
RUN export PATH=$PATH:~/ciao/build/bin

# Emacs
COPY add_to_emacs /home/emacs/add_to_emacs
RUN mkdir -p /home/emacs/.emacs.d/ && \
    touch /home/emacs/.emacs.d/init.el && \
    cat /home/emacs/add_to_emacs >> /home/emacs/.emacs.d/init.el && \
    echo "(setq default-directory \"${WORKSPACE}\")" >> /home/emacs/.emacs.d/init.el && \
    rm /home/emacs/add_to_emacs

# Clean
RUN apt-get clean && \
    apt-get -y autoremove
