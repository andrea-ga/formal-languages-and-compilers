import java.io.*;
   
public class Main {
	static public void main(String argv[]) {    
		try {
		/* Instantiate the scanner and open input file argv[0] */
			Yylex l = new Yylex(new FileReader(argv[0]));
			/* Instantiate the parser */
			parser p = new parser(l);
			/* Start the parser */
			Object result = p.parse();      
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
