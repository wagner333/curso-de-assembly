NOME = main

all: $(NOME)

$(NOME): $(NOME).o
	ld -o $(NOME) $(NOME).o

%.o: %.asm
	nasm -f elf64 $< -o $@

clean:
	rm -f *.o $(NOME)
