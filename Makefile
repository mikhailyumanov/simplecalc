target:
	bison -d parser.y -o parser.c
	flex -o lexer.c lexer.l
	gcc lexer.c parser.c -lfl
