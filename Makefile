LAZBUILD=/opt/lazarus/2.2.6/lazbuild --lazarusdir=/opt/lazarus/2.2.6/
ARCH_PARAMS=--os=darwin --ws=cocoa --cpu=x86_64
MINIAUDIO_PATH=vendor/miniaudio

build_ide:
	echo "Build IDE"
	$(LAZBUILD) $(ARCH_PARAMS) BGRABitmap/bgrabitmap/bgrabitmappack.lpk BGRAControls/bgracontrols.lpk BGRABitmap/bglcontrols/bglcontrols.lpk roundspineditpackage.lpk switchboxpackage.lpk


build_miniaudio:
	$(MINIAUDIO_PATH)/make build

arch_win_x86_64:
	ARCH_PARAMS=--os=win64 --ws=win32 --cpu=x86_64

arch_linux_x86_64:
	ARCH_PARAMS=--os=linux --ws=gtk2 --cpu=x86_64

build_project: build_ide build_miniaudio
	$(LAZBUILD) -B -r --os=darwin --ws=cocoa --cpu=x86_64 --no-write-project --bm=Release breath.lpi
	#$(LAZBUILD) -B -r --os=darwin --ws=cocoa --cpu=x86_64 --no-write-project --bm=Release breath.lpi

