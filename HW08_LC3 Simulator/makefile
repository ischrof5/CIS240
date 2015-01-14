all: trace

trace: trace.c ObjectFiles.c LC4.c ObjectFiles.h LC4.h
	clang -Wall -o trace trace.c ObjectFiles.c LC4.c

clean:
	rm trace

.PHONY: all clean