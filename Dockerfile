FROM ubuntu:20.04

RUN apt-get update -y --fix-missing
RUN apt-get install -y openssh-server make gcc g++

ARG USER
ARG UID
ARG GID

RUN useradd -rm -d /home/${USER} -s /bin/bash -g root -G sudo -u ${UID} jaeyong
RUN echo "${USER}:${USER}" | chpasswd
WORKDIR /home/${USER}

RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.4.tar.gz
RUN tar -xvf openmpi-4.1.4.tar.gz
RUN cd openmpi-4.1.4 && ./configure --prefix="/home/${USER}/opt/openmpi" && make -j 100 && make install -j 100
RUN chown -R ${USER}:root /home/${USER}/opt

USER ${USER}

RUN mkdir -p /home/${USER}/.ssh
COPY --chown=${USER}:${USER} authorized_keys /home/${USER}/.ssh/authorized_keys
RUN chmod 700 ~/.ssh
RUN chmod 600 ~/.ssh/authorized_keys

RUN echo "export PATH=\"$PATH:/home/${USER}/opt/openmpi/bin\"" | cat - ~/.bashrc > temp && mv temp ~/.bashrc
RUN echo "export LD_LIBRARY_PATH=\"$LD_LIBRARY_PATH:/home/${USER}/opt/openmpi/bin\"" | cat - ~/.bashrc > temp && mv temp ~/.bashrc

USER root
ENTRYPOINT service ssh start && /bin/bash
