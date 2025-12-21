NOME = Main

all: $(NOME)

$(NOME): $(NOME).o
	ld -m elf_i386 -o $(NOME) $(NOME).o

%.o: %.s
	nasm -f elf32 $< -o $@

clean:
	rm -f *.o $(NOME)
