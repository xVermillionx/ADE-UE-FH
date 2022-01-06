# FLAGS=-Mtp -Criot -gl 
INC=-Fu./Units #-Fu./

default: build


build:
	for f in *.pas; do fpc $(FLAGS) $(INC) $$f -o$${f%.pas}.bin ; done

list:
	ls -1 *.pas && LIST=($$(ls -1 *.pas)) && read -n 1 && fpc $(FLAGS) $(INC) $${LIST[$$REPLY-1]} -o$${LIST[$$REPLY-1]%.pas}.bin

cleanabit:
	rm -f *.o

%:
	fpc $(FLAGS) $(INC) $(@).pas -o$(@).bin

clean:
	rm -f Units/*.ppu
	rm -f Units/*.o
	rm -f *.bin
	rm -f *.o
