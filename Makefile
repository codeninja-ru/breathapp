.PHONY: clean crossbuild \
        build_win_x86_64 build_win_i386 \
        build_linux_x86_64_gtk2 build_linux_i386_gtk2 \
        build_linux_x86_64_qt build_linux_x86_64_qt5 build_linux_i386_qt5 \
        build_darwin_x86_64

LAZBUILD = /opt/lazarus/2.2.6/lazbuild --lazarusdir=/opt/lazarus/2.2.6/
PACKAGES = /opt/vendor/BGRABitmap/bgrabitmap/bgrabitmappack.lpk \
           /opt/vendor/BGRAControls/bgracontrols.lpk \
           /opt/vendor/BGRABitmap/bglcontrols/bglcontrols.lpk \
           roundspineditpackage.lpk switchboxpackage.lpk
PROJECT  = breath.lpi

clean:
	echo "TODO clean"

define build_template
$1:
	$(LAZBUILD) $2 $(PACKAGES) -B -r --no-write-project $(PROJECT)
endef

$(eval $(call build_template,build_win_x86_64,--os=win64 --ws=win32 --cpu=x86_64))
$(eval $(call build_template,build_win_i386,--os=win32 --ws=win32 --cpu=i386))
$(eval $(call build_template,build_linux_x86_64_gtk2,--os=linux --ws=gtk2 --cpu=x86_64))
$(eval $(call build_template,build_linux_i386_gtk2,--os=linux --ws=gtk2 --cpu=i386))
$(eval $(call build_template,build_linux_x86_64_qt,--os=linux --ws=qt --cpu=x86_64))
$(eval $(call build_template,build_linux_x86_64_qt5,--os=linux --ws=qt5 --cpu=x86_64))
$(eval $(call build_template,build_linux_i386_qt5,--os=linux --ws=qt5 --cpu=i386))
$(eval $(call build_template,build_darwin_x86_64,--os=darwin --ws=cocoa --cpu=x86_64))

crossbuild: build_win_x86_64 build_linux_x86_64_gtk2 build_linux_x86_64_qt5 build_win_i386
