BIN = ../bin

MAIN = main

TARGET = $(BIN)/$(MAIN)

FLAGS = -Wall -ansi -pedantic

CC = gcc

DEP = dependency


$(TARGET): $(BIN) $(BIN)/$(MAIN).o
	@echo "Creating run $(TARGET))"
	@$(CC) -g $(FLAGS) $(BIN)/$(MAIN).o -o $(TARGET)


.PHONY: clean run

$(BIN):
	@echo "Creatin binaries folder"
	@mkdir $(BIN)

run: $(TARGET)
	@echo "running file:\n\n"
	@$(TARGET)

$(BIN)/$(DEP).o: $(DEP).c $(DEP).h
	@echo "Creating $(DEP).o"
	@$(CC) -c $(FLAGS) $(DEP).c -o $(BIN)/$(DEP).o

$(BIN)/$(MAIN).o: $(MAIN).c
	@echo "Creating $(MAIN).o"
	@$(CC) -c $(FLAGS) $(MAIN).c -o $(BIN)/$(MAIN).o

clean:
	@echo "Removing all binaries"
	@rm -rf $(BIN)
