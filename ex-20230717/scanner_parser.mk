default: scanner parser

	javac *.java
	
scanner: 
	jflex scanner.jflex

parser:
	java java_cup.Main parser.cup
	
parser_tree:
	java java_cup.MainDrawTree -parser parser parser.cup
	
clean:
	rm -fr parser.java Yylex.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
	
run:
	java Main 20230717_flc.txt