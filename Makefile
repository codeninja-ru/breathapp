.PHONY: clean crossbuild \
        build_win_x86_64 build_win_i386 \
        build_linux_x86_64_gtk2 build_linux_i386_gtk2 \
        build_linux_x86_64_qt build_linux_x86_64_qt5 build_linux_i386_qt5 \
        build_darwin_x86_64

LAZBUILD = /opt/lazarus/$(LAZVER)/lazbuild --lazarusdir=/opt/lazarus/$(LAZVER)/
PACKAGES = /opt/vendor/BGRABitmap/bgrabitmap/bgrabitmappack.lpk \
           /opt/vendor/BGRAControls/bgracontrols.lpk \
           /opt/vendor/BGRABitmap/bglcontrols/bglcontrols.lpk \
           roundspineditpackage.lpk switchboxpackage.lpk
PROJECT  = breath.lpi

clean:
	rm -rf lib/*

define build_template
$1: clean
	$(LAZBUILD) $2 $(PACKAGES) -B -r --verbose --no-write-project --bm=Release $(PROJECT)
endef

$(eval $(call build_template,build_win_x86_64,--os=win64 --ws=win32 --cpu=x86_64 --compiler=/opt/fpc/$(FPCVER)/lib/fpc/$(FPCVER)/ppcrossx64_win64))
$(eval $(call build_template,build_win_i386,--os=win32 --ws=win32 --cpu=i386 --compiler=/opt/fpc/$(FPCVER)/lib/fpc/$(FPCVER)/ppcross386_win32))
$(eval $(call build_template,build_linux_x86_64_gtk2,--os=linux --ws=gtk2 --cpu=x86_64))
$(eval $(call build_template,build_linux_i386_gtk2,--os=linux --ws=gtk2 --cpu=i386 --compiler=/opt/fpc/$(FPCVER)/lib/fpc/$(FPCVER)/ppcross386_linux))
$(eval $(call build_template,build_linux_x86_64_qt5,--os=linux --ws=qt5 --cpu=x86_64))
$(eval $(call build_template,build_linux_i386_qt5,--os=linux --ws=qt5 --cpu=i386 --compiler=/opt/fpc/$(FPCVER)/lib/fpc/$(FPCVER)/ppcross386_linux))
$(eval $(call build_template,build_darwin_x86_64,--os=darwin --ws=cocoa --cpu=x86_64 --compiler=/opt/fpc/$(FPCVER)/lib/fpc/$(FPCVER)/ppcrossx64_darwin))
#$(eval $(call build_template,build_darwin_aarch64,--os=darwin --ws=cocoa --cpu=aarch64))

crossbuild: 
	$(MAKE) build_win_x86_64 
	$(MAKE) build_linux_x86_64_gtk2 
	$(MAKE) build_linux_x86_64_qt5 
	$(MAKE) build_darwin_x86_64
	$(MAKE) build_win_i386
	$(MAKE) build_linux_i386_gtk2
	$(MAKE) build_linux_i386_qt5
	upx bin/breath-linux-*
	upx bin/breath-win*
#	upx bin/breath-darwin* # darwin is not supported by upx yet
