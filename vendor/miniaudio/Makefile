MINIAUDIO_SOURCE = miniaudio_lib.c
MINIAUDIO_OUT = miniaudio_lib.o
.PHONY: debug build

clean:
	-rm *.res
	-rm *.o
	-rm *.ppu

miniaudio:
	@echo "Build: $(MINIAUDIO_SOURCE)"
	gcc $(flag) -c $(MINIAUDIO_SOURCE) -o $(MINIAUDIO_OUT)

build: clean miniaudio

debug: flag = -g

debug: build
