-- pour générer l'analyseur lexicale :
	- flex lexer.l
	- gcc -o "output_filename" "scanner.c" -lfl
	- ./"output_filename" (to run the analyzer)
	
-- pour générer l'analyseur syntaxique (et lexical) : 
	- bison -d syntax.y
	- flex lexer.l
	- gcc -o output syntax.tab.c scanner.c -lfl -lm 
	- ./"output_filename" "input_filename.txt" (to run the analyzer)
