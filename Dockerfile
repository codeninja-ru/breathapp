# syntax=docker/dockerfile:1
FROM debian:bookworm

# see https://wiki.freepascal.org/Cross_compiling_for_Windows_under_Linux

# todo remove lazarus-src
# https://packages.debian.org/bookworm/gcc-mingw-w64
RUN apt-get update && apt-get install -y wget unzip make binutils clang libgtk2.0-dev

COPY <<-"EOF" build.sh
#!/bin/sh

export FPCVER="3.2.2"
export PATH="/opt/fpc/$FPCVER/bin/:/opt/lazarus/2.2.6/:$PATH"
echo "PATH=\"/opt/fpc/$FPCVER/bin/\":\"/opt/lazarus/2.2.6/\":\"\$PATH\"" >> ~/.bashrc

# install fpc
mkdir -p /opt/fpc/$FPCVER && cd /opt/fpc/$FPCVER
wget -O /tmp/fpc-bin.tar https://sourceforge.net/projects/freepascal/files/Linux/3.2.2/fpc-$FPCVER.$(uname -m)-linux.tar
mkdir -p /tmp/fpc-bin
tar xvf /tmp/fpc-bin.tar -C /tmp/fpc-bin --strip-components=1 && cd /tmp/fpc-bin
echo "/opt/fpc/$FPCVER" | ./install.sh
fpcmkcfg -d basepath="/opt/fpc/$FPCVER/lib/fpc/\$fpcversion" -p -o ~/fpc.cfg
cd /opt/fpc && rm -rf /tmp/fpc-bin && rm /tmp/fpc-bin.tar

## install fpc sources
mkdir -p /opt/fpcsrc/$FPCVER && cd /opt/fpcsrc/$FPCVER
wget -O /tmp/fpc-source.tar.gz https://sourceforge.net/projects/freepascal/files/Source/$FPCVER/fpc-$FPCVER.source.tar.gz/download
tar xzvf /tmp/fpc-source.tar.gz -C /opt/fpcsrc/$FPCVER/ --strip-components=1
rm /tmp/fpc-source.tar.gz
make clean all OS_TARGET=win64 CPU_TARGET=x86_64
make clean all OS_TARGET=win32 CPU_TARGET=i386
make crossinstall OS_TARGET=win64 CPU_TARGET=x86_64 INSTALL_PREFIX=/opt/fpc/$FPCVER
make crossinstall OS_TARGET=win32 CPU_TARGET=i386 INSTALL_PREFIX=/opt/fpc/$FPCVER
#ln -sf "/opt/fpc/${FPCVER}/ppcrossx64" /usr/bin/ppcrossx64
#ln -sf "/usr/lib/fpc/${FPCVER}/ppcross386" /usr/bin/ppcross386
#echo "\\n-Fu/usr/lib/fpc/\$fpcversion/units/\$fpctarget/*" >> ~/fpc.cfg

# lazarus
mkdir -p /opt/lazarus/ && cd /opt/lazarus
wget https://gitlab.com/freepascal.org/lazarus/lazarus/-/archive/lazarus_2_2_6/lazarus-lazarus_2_2_6.zip && unzip -e lazarus-lazarus_2_2_6.zip
rm lazarus-lazarus_2_2_6.zip
mv lazarus-lazarus_2_2_6 2.2.6 && cd 2.2.6
make lazbuild
EOF

RUN chmod +x build.sh
RUN ./build.sh

#
#RUN cp -r /usr/shared/src /tmp && cd /tmp/src
#RUN wget https://packages.lazarus-ide.org/BGRABitmap.zip && unzip -e BGRABitmap.zip
#RUN wget https://packages.lazarus-ide.org/BGRAControls.zip && unzip -e BGRAControls.zip

WORKDIR /usr/src
