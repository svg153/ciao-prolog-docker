FROM jare/emacs

ENV libroot /opt/ciao

# Update packages for ubuntu:lastest
RUN dpkg --add-architecture i386 && \
    apt-get -y update > /dev/null 2>&1 && \
    apt-get -y install \
        wget libxm4:i386 \
    > /dev/null 2>&1

# Download ciao prolog
#RUN wget -q http://www.clip.dia.fi.upm.es/packages/1.14/13646/CiaoDE-1.14.2-13646.i386.deb /home/emacs/ciao.deb
# |-> ERROR: http://ciao-lang.org/cgi-bin/download.cgi?url=/packages/1.14/13646/CiaoDE-1.14.2-13646.i386.deb&list=ciao-users
RUN wget -q https://ciao-lang.org/packages/1.14/13646/CiaoDE-1.14.2-13646.i386.deb -O ./ciao.deb
RUN sudo dpkg -i ./ciao.deb
RUN rm ./ciao.deb
ENV CIAO /usr/lib/ciao/
# -> path in .emacs.d/init.et

# Configure ciao
##
COPY addTo_bashrc /home/emacs/addTo_bashrc
RUN cat /home/emacs/addTo_bashrc >> /home/emacs/.bashrc && \
    rm /home/emacs/addTo_bashrc

# Emacs
COPY addTo_emacs /home/emacs/addTo_emacs
RUN mkdir -p /home/emacs/.emacs.d/ && \
    touch /home/emacs/.emacs.d/init.el && \
    cat /home/emacs/addTo_emacs >> /home/emacs/.emacs.d/init.el && \
    rm /home/emacs/addTo_emacs
