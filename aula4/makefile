NOME = testelib

all: $(NOME)

$(NOME): $(NOME).o
	ld -o $(NOME) $(NOME).o

%.o: %.s
	nasm -f elf64 $< -o $@

clean:
	rm -f *.o $(NOME)
