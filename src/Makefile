AS_FLAGS = -g --32
LD_FLAGS = -m elf_i386

SRC = atoi.s blif.s emit.s equals.s fprint.s fputs.s getchar.s itoa.s\
	  main.s num2bin.s opcode.s print.s puts.s regcode.s word.s

OBJ = $(SRC:.s=.o)
BIN = a.out

$(BIN): $(OBJ)
	ld -o $@ $(OBJ) $(LD_FLAGS)

$(OBJ): %.o: %.s
	as -o $@ $< $(AS_FLAGS)

clean:
	@rm -f $(OBJ) $(BIN)
