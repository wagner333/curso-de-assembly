nome = Main
ASM = $(nome).s
CPP = $(nome).cpp
ASMOBJ = $(nome)_asm.o
CPPOBJ = $(nome).o
OBJS = $(CPPOBJ) $(ASMOBJ)

all: $(nome)

$(ASMOBJ): $(ASM)
	nasm -f elf64 -o $@ $<

$(CPPOBJ): $(CPP)
	g++ -c -o $@ $<

$(nome): $(OBJS)
	g++ -o $@ $(OBJS)

clean:
	rm -f $(OBJS) $(nome)