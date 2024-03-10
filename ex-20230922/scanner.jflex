import java_cup.runtime.*;

%%
//%class Lexer
//%standalone
%unicode
%cup
%line
%column

%{
	private Symbol sym(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	
	private Symbol sym(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
	
%}

//q_string = \" ~ \"
unsigned_int = 0 | [1-9][0-9]*
//real_number = ("+"|"-")?([1-9][0-9]*"."[0-9]*) | ("."[0-9]+) | (0"."[0-9]*)

sep = "##"
comment = "[[+" ~ "+]]"

token1 = "A_"(({num}"*"){3} | ({num}"*"){6} | ({num}"*"){10}){num}
num = ("-"(273 | 2[0-6][13579] | 1[0-9][13579] | [0-9][13579] | [13579])) 
      | 
      (([13579] | [1-9][13579] | [1-3][0-9][13579] | 4[0-4][13579] | 457))

token2 = "B_"{date}
date = (2023"/"
            (
                ((09 | "September")"/"
                    (2[2-9] | 30)
                )
                |
                ((10 | "October")"/"
                    (0[1-9] | 1[0-9] | 2[0-9] | 3[01])
                )
                |
                ((11 | "November")"/"
                    (0[1-9] | 1[0-9] | 2[0-9] | 30)
                )
                |
                ((12 | "December")"/"
                    (0[1-9] | 1[0-9] | 2[0-9] | 3[01])
                )
            )
       )
       |
       (2024"/"
            (
                ((01 | "January")"/"
                    (0[1-9] | 1[0-9] | 2[0-9] | 3[01])
                )
                |
                ((02 | "February")"/"
                    (0[0-7])
                )
            )
       )

token3 = "C_"{hex_rep}("*"|"$"|"&"){hex_rep}("*"|"$"|"&"){hex_rep}("*"|"$"|"&"){hex_rep}(("*"|"$"|"&"){hex_rep}("*"|"$"|"&"){hex_rep})*
hex_rep = [0-9a-fA-F]{4} | [0-9a-fA-F]{8}

%%

//SCANNER
/*
";"         {System.out.println("SC: " + yytext()); }
//"->"          {System.out.println("ARROW: " + yytext()); }
"-"		    {System.out.println("MINUS: " + yytext()); }
"+"		    {System.out.println("PLUS: " + yytext()); }
"/"		    {System.out.println("DIV: " + yytext()); }
"*"		    {System.out.println("STAR: " + yytext()); }
"("		    {System.out.println("OB: " + yytext()); }
")"		    {System.out.println("CB: " + yytext()); }
"["		    {System.out.println("OS: " + yytext()); }
"]"		    {System.out.println("CS: " + yytext()); }
","		    {System.out.println("C: " + yytext()); }
//"."		    {System.out.println("D: " + yytext()); }
//":"		    {System.out.println("DD: " + yytext()); }
//"="		    {System.out.println("EQ: " + yytext()); }

"INS"       {System.out.println("INS_WORD: " + yytext()); }
"CMP"       {System.out.println("CMP_WORD: " + yytext()); }
"SUM"       {System.out.println("SUM_WROD: " + yytext()); }

{sep}       {System.out.println("SEP: " + yytext()); }
{token1}    {System.out.println("TOKEN1: " + yytext()); }
{token2}    {System.out.println("TOKEN2: " + yytext()); }
{token3}    {System.out.println("TOKEN3: " + yytext()); }

//{q_string}	    {System.out.println("QSTRING: " + yytext()); }
{unsigned_int}	{System.out.println("UINT: " + yytext()); }
//{real_number}	    {System.out.println("RNUMBER: " + yytext()); }
*/

//SCANNER + PARSER
";"		    {return sym(sym.SC); }
//"->"          {return sym(sym.ARROW); }
"-"		    {return sym(sym.MINUS); }
"+"		    {return sym(sym.PLUS); }
"/"		    {return sym(sym.DIV); }
"*"		    {return sym(sym.STAR); }
"("		    {return sym(sym.OB); }
")"		    {return sym(sym.CB); }
"["		    {return sym(sym.OS); }
"]"		    {return sym(sym.CS); }
","		    {return sym(sym.C); }
//"."		    {return sym(sym.D); }
//":"		    {return sym(sym.DD); }
//"="		    {return sym(sym.EQ); }

"INS"       {return sym(sym.INS_WORD); }
"CMP"       {return sym(sym.CMP_WORD); }
"SUM"       {return sym(sym.SUM_WORD); }

{sep}       {return sym(sym.SEP); }
{token1}    {return sym(sym.TOKEN1); }
{token2}    {return sym(sym.TOKEN2); }
{token3}    {return sym(sym.TOKEN3); }

//{q_string}	    {return sym(sym.QSTRING, new String(yytext())); }
{unsigned_int}	{return sym(sym.UINT, new Integer(yytext())); }
//{real_number}	    {return sym(sym.RNUMBER, new Float(yytext())); }


{comment} 	{;}
\r | \n | \r\n | " " | \t	{;}
.			{ System.out.println("Scanner Error: " + yytext()); }
