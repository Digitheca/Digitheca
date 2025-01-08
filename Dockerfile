from ubuntu:24.04

env DEBIAN_FRONTEND=noninteractive  \
    SDKMAN_DIR=/home/ubuntu/.sdkman \
    PATH=/home/ubuntu/.sdkman/bin:/home/ubuntu/.sdkman/candidates/kotlin/current/bin:$PATH

run apt-get update    -y     && \
    apt-get upgrade   -y     && \
    apt-get install   -y        \
        --no-install-recommends \
        ca-certificates         \
        curl                    \
        git                     \
        make                    \
        sudo                    \
        unzip                   \
        zip                  && \
    apt-get autoclean -y     && \
    rm -rf /var/lib/apt/lists/*

run usermod -aG sudo ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ubuntu

user 1000:1000

run cd                                              && \
    bash -c "curl -s 'https://get.sdkman.io' | bash && \
    source $SDKMAN_DIR/bin/sdkman-init.sh           && \
    sdk install java 21.0.5-tem                     && \
    sdk install kotlin 2.1.0                        && \
    sudo chown -R ubuntu:ubuntu /home/ubuntu/"

workdir "/home/ubuntu/"

cmd ["/bin/bash"]
