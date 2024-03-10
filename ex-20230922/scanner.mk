default: scanner

	javac *.java
	
scanner: 
	jflex scanner.jflex
	javac Lexer.java

clean:
	rm -vfr *.class
	rm -vfr *.*~
	
run:
	java Lexer 20230922_flc.txt