cal : lex.yy.c y.tab.c y.tab.h
	gcc -o cal lex.yy.c y.tab.c -lfl -lm

y.tab.c y.tab.h : cal.y
	yacc -vd cal.y

lex.yy.c : cal.l
	flex cal.l

clean:
	rm -f *.o y.* lex.yy.c y.tab.c. cal
