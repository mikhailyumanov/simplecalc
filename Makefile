all: test

build:
	bison -d parser.y -o parser.c
	flex -o lexer.c lexer.l
	gcc lexer.c parser.c -lfl -o simplecalc

test: build
	./run_tests.sh
