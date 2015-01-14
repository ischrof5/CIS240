all : jc

jc : parser.c parser.h token.c token.h map.c map.h
	clang -Wall -o jc parser.c token.c map.c

token.o : token.c token.h
	clang -c token.c

test_token : test_token.c token.o
	clang -o test_token test_token.c token.o

parser.o : parser.c parser.h token.h 
	clang -c parser.c

test_parser : test_parser.c parser.o token.o
	clang -o test_parser test_parser.c parser.o token.o
