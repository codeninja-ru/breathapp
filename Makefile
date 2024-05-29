LAZBUILD=/Applications/Lazarus/lazbuild

build:
	$(LAZBUILD) -B -r --os=darwin --ws=cocoa --cpu=x86_64 --no-write-project --bm=Release breath.lpi

