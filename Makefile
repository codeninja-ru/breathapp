LAZBUILD=/opt/lazarus/2.2.6/lazbuild --lazarusdir=/opt/lazarus/2.2.6/

clean:
	echo "TODO clean"

build_win_x86_64: ARCH_PARAMS = --os=win64 --ws=win32 --cpu=x86_64
build_win_x86_64: build

build_win_i386: ARCH_PARAMS = --os=win32 --ws=win32 --cpu=i386
build_win_i386: build

build_linux_x86_64_gtk2: ARCH_PARAMS = --os=linux --ws=gtk2 --cpu=x86_64
build_linux_x86_64_gtk2: build

# TODO error
# /usr/bin/ld: /opt/fpc/3.2.2/lib/fpc/3.2.2/units/i386-linux/rtl/si_c21.o: in function `SI_C21_$$__FPC_LIBC21_START':
# si_c21.pp:(.text.n_si_c21_$$__fpc_libc21_start+0x27): undefined reference to `__libc_csu_fini'
# /usr/bin/ld: si_c21.pp:(.text.n_si_c21_$$__fpc_libc21_start+0x2c): undefined reference to `__libc_csu_init'
# FIXME: https://gitlab.com/freepascal.org/fpc/source/-/commit/b12bb768ca96562a2021d94a7be5857b0c5b2591
# FIXME: https://forum.lazarus.freepascal.org/index.php?topic=58877.0
build_linux_i386_gtk2: ARCH_PARAMS = --os=linux --ws=gtk2 --cpu=i386
build_linux_i386_gtk2: build

# TODO apt install libqt5pas-dev
build_linux_x86_64_qt: ARCH_PARAMS = --os=linux --ws=qt --cpu=x86_64
build_linux_x86_64_qt: build

build_linux_x86_64_qt5: ARCH_PARAMS = --os=linux --ws=qt5 --cpu=x86_64
build_linux_x86_64_qt5: build

build_linux_i386_qt5: ARCH_PARAMS = --os=linux --ws=qt5 --cpu=i386
build_linux_i386_qt5: build

build_darwin_x86_64: ARCH_PARAMS = --os=darwin --ws=cocoa --cpu=x86_64
build_darwin_x86_64: build

build: clean	
	$(LAZBUILD) $(ARCH_PARAMS) vendor/BGRABitmap/bgrabitmap/bgrabitmappack.lpk vendor/BGRAControls/bgracontrols.lpk vendor/BGRABitmap/bglcontrols/bglcontrols.lpk roundspineditpackage.lpk switchboxpackage.lpk -B -r --no-write-project --bm=Release breath.lpi

crossbuild: build_win_x86_64 build_linux_x86_64_gtk2 build_linux_x86_64_qt5 build_win_i386

