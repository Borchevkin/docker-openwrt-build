FROM ubuntu:22.04 as base

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV XDG_CACHE_HOME=/root/.cache
ENV FORCE_UNSAFE_CONFIGURE=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root/

RUN \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        # C/C++
        build-essential \
        g++ \
        bison \
        ccache \
        cmake \
        clang \
        clang-tools \
        clang-format \
        gcc-multilib \
        g++-multilib \
        device-tree-compiler \
        swig \
        cppcheck \ 
        doxygen \
        graphviz \
        # Shell
        shellcheck \ 
        # Python
        python2.7 \
        python2.7-dev \
        python3 \
        python3-dev \
        python3-pip \
        python3-distutils \
        python3-setuptools \
        # Lua 5.1
        libjson-c-dev \
        libreadline-dev \
        lua5.1 \
        liblua5.1-0-dev \
        # Java
        java-propose-classpath \  
        fastjar \
        ecj \
        # Other programming
        flex \
        xsltproc \ 
        gawk \ 
        # Emulators
        qemu \
        qemu-utils \
        # Libs
        libncurses5-dev \
        libncursesw5-dev \
        libssl-dev \
        zlib1g-dev \
        libelf-dev  \
        zlib1g-dev \
        libpam-modules \
        libpam-dev \
        liblzma-dev \
        liblzma5 \
        libsnmp-base \
        libsnmp-dev \
        # Common tools
        software-properties-common \
        screen \
        subversion \
        ssh \
        git \
        wget \
        curl \
        zip \
        unzip \
        rsync \
        file \
        time \
        gettext \
        xorriso \
        vim \
        && \
    apt-add-repository -y ppa:rael-gc/rvm && \
    apt-add-repository -y ppa:ubuntu-toolchain-r/test && \
    add-apt-repository -y ppa:brandonsnider/cdrtools && \
    apt-get update && \
    apt-get install -y \
        rvm \
        gcc-9 \
        gcc-10 \
        gcc-11 \
        g++-9 \
        g++-10 \
        g++-11 \
        mkisofs \
        && \
    # Clean apt-get 
    apt-get -y clean && \ 
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*
RUN \
    # Git fix - use https instead of ssh. Needed for Luarocks
    git config --global url."https://".insteadOf git:// && \
    # Luarocks and Lua dependencies
    wget https://luarocks.org/releases/luarocks-3.9.2.tar.gz && \
    tar zxpf luarocks-3.9.2.tar.gz && \
    cd luarocks-3.9.2 && ./configure && make && make install && cd .. && \
    rm -r -f luarocks-3.9.2 && rm -f luarocks-3.9.2.tar.gz && \
    # Lua dependencies
    luarocks install --deps-mode=all luasec && \
    luarocks install --deps-mode=all busted && \
    luarocks install --deps-mode=all luacheck && \
    luarocks install --deps-mode=all mobdebug  && \
    luarocks install --deps-mode=all ldoc && \
    luarocks install --deps-mode=all --server=https://luarocks.org/dev luaformatter && \
    # Git fixes
    git config --global safe.directory '*' && \
    git config --global --unset url."https://".insteadOf git://
RUN \
    # Python dependecies
    pip3 install --upgrade pip --no-cache-dir && \
    pip3 install --no-cache-dir \
        flawfinder \
        gcovr \
        cffi \
        cryptography \
        junit2html \
        && \
    python3 -m pip cache purge
RUN \
    # Ruby 2.7 and dependecies
    source /usr/share/rvm/scripts/rvm && \
    echo "source /usr/share/rvm/scripts/rvm" > /root/.bashrc && \
    rvm pkg install openssl && \
    rvm install 2.7 --with-openssl-dir=/usr/share/rvm/usr && \
    rvm use 2.7 --default && \
    gem install ceedling && \
    gem sources -c
RUN \
    # gcc and g++ set up
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 11 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 10 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 11 && \
    # Set gcc to 9.x.x
    update-alternatives --set gcc /usr/bin/gcc-9 && \
    # Set g++ to 9.x.x
    update-alternatives --set g++ /usr/bin/g++-9
RUN \
    # Libubox
    git clone --branch master https://github.com/openwrt/libubox && \
    cd libubox && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf libubox
RUN \
    # Ubus
    git clone --branch master https://github.com/openwrt/ubus && \
    cd ubus && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf ubus
RUN \
    # UCI
    git clone --branch master https://github.com/openwrt/uci && \
    cd uci && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf uci
RUN \
    # Nixio lua (no TLS)
    git clone --branch master https://github.com/Neopallium/nixio && \
    cd nixio && \
    make NIXIO_TLS=  && \
    make install NIXIO_TLS= && \
    cd ../ && \
    rm -rf nixio
RUN \
    # Google Test
    git clone --depth 1 --branch release-1.12.0 --single-branch https://github.com/google/googletest && \
    cd googletest && \
    mkdir build && \
    cd build && \
    cmake .. -DBUILD_GMOCK=OFF -DBUILD_SHARED_LIBS=ON && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf googletest
RUN \
    # Fake Function Framework
   mkdir fff && \
   cd fff && \
   git init && \
   git remote add origin https://github.com/meekrosoft/fff && \
   git fetch origin 5111c61e1ef7848e3afd3550044a8cf4405f4199 && \
   git reset --hard FETCH_HEAD && \
   cp fff.h /usr/local/include/ && \
   cd ../ && \
   rm -rf fff
RUN \
    # Update ldconfig
    ldconfig /usr/local/lib
