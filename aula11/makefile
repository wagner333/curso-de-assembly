NOME = Main
ASM = $(NOME).s
CPP = $(NOME).cpp
ASM_OBJ = $(NOME)_asm.o
CPP_OBJ = $(NOME)_cpp.o
all: $(NOME)
$(NOME): $(ASM_OBJ) $(CPP_OBJ)
	g++ $(ASM_OBJ) $(CPP_OBJ) -o $(NOME)
$(ASM_OBJ): $(ASM)
	nasm -f elf64 $(ASM) -o $(ASM_OBJ)
$(CPP_OBJ): $(CPP)
	g++ -c $(CPP) -o $(CPP_OBJ)
clean:
	rm -f *.o $(NOME)

