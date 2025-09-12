# syntax=docker/dockerfile:1
FROM debian:bookworm

# see https://wiki.freepascal.org/Cross_compiling_for_Windows_under_Linux

# TODO update fpc.cfg with pathes for mingw libs
# https://packages.debian.org/bookworm/gcc-mingw-w64
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y wget unzip make binutils clang libgtk2.0-dev libqt5pas-dev
# linux x86_64 to linux i386
RUN apt-get install -y libc6-dev-i386  libx11-6:i386  libx11-dev:i386  libgdk-pixbuf2.0-0:i386  libatk1.0-dev:i386 libgdk-pixbuf2.0-dev:i386  libpango1.0-dev:i386  libgtk2.0-dev:i386 libnotify-dev:i386 libqt5pas-dev:i386
# gcc cross compile
RUN apt-get install -y mingw-w64-x86-64-dev mingw-w64-i686-dev
# osxcross deps
RUN apt-get install -y bzip2-doc llvm llvm-runtime cmake git

# MacOs sdk and lazarus components
COPY ./vendor/MacOSX*.1.sdk.tar.xz /tmp
COPY ./vendor/BGRAControls.zip /tmp
COPY ./vendor/BGRABitmap.zip /tmp

# fix for i386 fpc 3.2.2 / remove when fpc 3.2.4 is out
COPY <<-"EOF" /tmp/si_c21.patch
--- si_c21.inc	2019-11-09 22:07:33.000000000 +0000
+++ si_c21_.inc	2024-12-24 14:14:33.658015528 +0000
@@ -35,8 +35,12 @@

 {$asmmode att}

-procedure __libc_csu_init; cdecl; external;
-procedure __libc_csu_fini; cdecl; external;
+procedure __libc_csu_init; cdecl;
+begin
+end;
+procedure __libc_csu_fini; cdecl;
+begin
+end;
 procedure libc_start_main; external name '__libc_start_main';
 procedure libc_exit(code: longint); cdecl; external name 'exit';

EOF

COPY <<-"EOF" build.sh
#!/bin/sh

export FPCVER="3.2.2"
echo 'export FPCVER="3.2.2"' >> ~/.bashrc
export PATH="/opt/fpc/$FPCVER/bin/:/opt/lazarus/2.2.6/:/opt/osxcross/target/bin/:$PATH"
echo "PATH=\"/opt/fpc/$FPCVER/bin/\":\"/opt/lazarus/2.2.6/\":\"/opt/osxcross/target/bin/\":\"\$PATH\"" >> ~/.bashrc

# install fpc
mkdir -p /opt/fpc/$FPCVER && cd /opt/fpc/$FPCVER
wget -O /tmp/fpc-bin.tar https://sourceforge.net/projects/freepascal/files/Linux/3.2.2/fpc-$FPCVER.$(uname -m)-linux.tar
mkdir -p /tmp/fpc-bin
tar xvf /tmp/fpc-bin.tar -C /tmp/fpc-bin --strip-components=1 && cd /tmp/fpc-bin
echo "/opt/fpc/$FPCVER" | ./install.sh
fpcmkcfg -d basepath="/opt/fpc/$FPCVER/lib/fpc/\$fpcversion" -p -o ~/fpc.cfg
cd /opt/fpc && rm -rf /tmp/fpc-bin && rm /tmp/fpc-bin.tar


# linux x86_64 to linux i386
cat >/usr/bin/i386-linux-ld << EOT
#!/bin/bash
ld -A elf32-i386 \$@
EOT
chmod +x /usr/bin/i386-linux-ld
cat >/usr/bin/i386-linux-as << EOT
#!/bin/bash
as --32 \$@
EOT
chmod +x /usr/bin/i386-linux-as

# install osxcross
cd /opt && wget https://github.com/tpoechtrager/osxcross/archive/refs/heads/master.zip -O osxcross.zip
unzip -e osxcross.zip && mv osxcross-master osxcross && rm osxcross.zip
#todo sdk
mv /tmp/MacOSX*.1.sdk.tar.xz /opt/osxcross/tarballs
cd /opt/osxcross
./tools/get_dependencies.sh
UNATTENDED=1 ./build.sh
cat >/usr/bin/x86_64-darwin-clang << EOT
#!/bin/bash
x86_64-apple-darwin20.2-clang \$@
EOT
chmod +x /usr/bin/x86_64-darwin-clang
cat >/usr/bin/x86_64-darwin-ld << EOT
#!/bin/bash
x86_64-apple-darwin20.2-ld \$@
EOT
chmod +x /usr/bin/x86_64-darwin-ld

## install fpc sources
mkdir -p /opt/fpcsrc/$FPCVER && cd /opt/fpcsrc/$FPCVER
wget -O /tmp/fpc-source.tar.gz https://sourceforge.net/projects/freepascal/files/Source/$FPCVER/fpc-$FPCVER.source.tar.gz/download
tar xzvf /tmp/fpc-source.tar.gz -C /opt/fpcsrc/$FPCVER/ --strip-components=1
rm /tmp/fpc-source.tar.gz
patch /opt/fpcsrc/3.2.2/rtl/linux/i386/si_c21.inc < /tmp/si_c21.patch
make clean all OS_TARGET=win64 CPU_TARGET=x86_64
make clean all OS_TARGET=win32 CPU_TARGET=i386
make crossinstall OS_TARGET=win64 CPU_TARGET=x86_64 INSTALL_PREFIX=/opt/fpc/$FPCVER
make crossinstall OS_TARGET=win32 CPU_TARGET=i386 INSTALL_PREFIX=/opt/fpc/$FPCVER
#echo "\\n-Fu/usr/lib/fpc/\$fpcversion/units/\$fpctarget/*" >> ~/fpc.cfg

sudo make all OS_TARGET=linux CPU_TARGET=i386
make crossinstall OS_TARGET=linux CPU_TARGET=i386 INSTALL_PREFIX=/opt/fpc/$FPCVER

#cat >> /root/fpc.cfg << EOT
##IFDEF darwin
#-Fu/opt/osxcross/target/lib/fpc/$fpcversion/units/x86_64-darwin/
#-Fu/opt/osxcross/target/lib/fpc/$fpcversion/units/x86_64-darwin/*
#-Fu/opt/osxcross/target/lib/fpc/$fpcversion/units/x86_64-darwin/rtl
#-FD/opt/osxcross/target/bin"
##ENDIF
#EOT

make clean all OS_TARGET=darwin CPU_TARGET=x86_64 OPT="-Fl/opt/osxcross/target/SDK/MacOSX11.1.sdk/usr/lib" CROSSBINDIR=/opt/osxcross/target/bin/ BINUTILSPREFIX=x86_64-apple-darwin20.2-
#make clean all OS_TARGET=darwin CPU_TARGET=x86_64
make crossinstall OS_TARGET=darwin CPU_TARGET=x86_64 INSTALL_PREFIX=/opt/fpc/$FPCVER 

ln -sf /opt/fpc/${FPCVER}/lib/fpc/${FPCVER}/ppcross386 /usr/bin/ppcross386
ln -sf /opt/fpc/${FPCVER}/lib/fpc/${FPCVER}/ppcrossx64 /usr/bin/ppcrossx64

# lazarus
mkdir -p /opt/lazarus/ && cd /opt/lazarus
wget https://gitlab.com/freepascal.org/lazarus/lazarus/-/archive/lazarus_2_2_6/lazarus-lazarus_2_2_6.zip && unzip -e lazarus-lazarus_2_2_6.zip
rm lazarus-lazarus_2_2_6.zip
mv lazarus-lazarus_2_2_6 2.2.6 && cd 2.2.6
make lazbuild

# unpack project deps
mkdir -p /opt/vendor
mv /tmp/BGRABitmap.zip /opt/
mv /tmp/BGRAControls.zip /opt/
cd /opt/vendor
unzip -e BGRABitmap.zip
unzip -e BGRAControls.zip

cd /usr/src
EOF

COPY <<-"EOF" make.sh
# run docker like this: docker run -v $(pwd):/usr/src_mapped -it breath ./make.sh
make crossbuild
EOF

RUN chmod +x build.sh
RUN ./build.sh

WORKDIR /usr/src

#TODO macos sdks https://github.com/phracker/MacOSX-SDKs/releases
# https://github.com/tpoechtrager/osxcross

#
#RUN cp -r /usr/shared/src /tmp && cd /tmp/src
#RUN wget https://packages.lazarus-ide.org/BGRABitmap.zip && unzip -e BGRABitmap.zip
#RUN wget https://packages.lazarus-ide.org/BGRAControls.zip && unzip -e BGRAControls.zip
