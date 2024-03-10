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

q_string = \" ~ \"
unsigned_int = 0 | [1-9][0-9]*
real_number = ("+"|"-")?([1-9][0-9]*"."[0-9]*) | ("."[0-9]+) | (0"."[0-9]*)

sep = "***"
comment = ("{{" ~ "}}") | ("//".*) 

token1 = {hex}"*"{odd_alph}"-"({even_stars} | {word_xy})?
hex = 27[a-fA-F] |
      2[8-9][0-1a-fA-F] |
      [3-9a-fA-F][0-9a-fA-F][0-9a-fA-F] |
      1[0-1][0-9a-fA-F][0-9a-fA-F] |
      12[a][0-9a-fA-F] |
      12b[0-3] 
odd_alph = {alph}{5}({alph}{alph})*
alph = [a-zA-Z]
even_stars = "****"("**")*
word_xy = "Y""X"("XX")*"Y"

token2 = {ip}"-"{date}
ip = {ip_num}"."{ip_num}"."{ip_num}"."{ip_num}
ip_num = (2(([0-4][0-9])|(5[0-5])))|(1[0-9][0-9])|([1-9][0-9])|([0-9])
date = (2023"/"
            (
                (10"/"
                    (([0][5-9]) | ([1-2][0-9]) | (3[01]))
                )
                |
                (11"/"
                    (([0-2][0-9]) | (30))
                )
                |
                (12"/"
                    (([0-2][0-9]) | (3[01]))
                )
            )
        )
        |
        (2024"/"
            (
                (01"/"
                    (([0-2][0-9]) | (3[01]))
                )
                |
                (02"/"
                    (([0-2][0-9]))
                )
                |
                (03"/"
                    ((0[1-3]))
                )
            )
        )

token3 = ([0-9]{4,6}("-"|"+")){2,4}([0-9]{4,6})

%%

//SCANNER
/*
";"         {System.out.println("SC: " + yytext()); }
//"->"          {System.out.println("ARROW: " + yytext()); }
"-"		    {System.out.println("MINUS: " + yytext()); }
//"+"		    {System.out.println("PLUS: " + yytext()); }
//"/"		    {System.out.println("DIV: " + yytext()); }
//"*"		    {System.out.println("STAR: " + yytext()); }
//"("		    {System.out.println("OB: " + yytext()); }
//")"		    {System.out.println("CB: " + yytext()); }
//"["		    {System.out.println("OS: " + yytext()); }
//"]"		    {System.out.println("CS: " + yytext()); }
","		    {System.out.println("C: " + yytext()); }
//"."		    {System.out.println("D: " + yytext()); }
//":"		    {System.out.println("DD: " + yytext()); }
//"=="          {System.out.println("DEQ: " + yytext()); }
//"="		    {System.out.println("EQ: " + yytext()); }

"euro"       {System.out.println("EURO_WORD: " + yytext()); }
"%"          {System.out.println("PERC_WORD: " + yytext()); }

{sep}       {System.out.println("SEP: " + yytext()); }
{token1}    {System.out.println("TOKEN1: " + yytext()); }
{token2}    {System.out.println("TOKEN2: " + yytext()); }
{token3}    {System.out.println("TOKEN3: " + yytext()); }

{q_string}	    {System.out.println("QSTRING: " + yytext()); }
{unsigned_int}	{System.out.println("UINT: " + yytext()); }
{real_number}	{System.out.println("RNUMBER: " + yytext()); }
*/

//SCANNER + PARSER
";"		    {return sym(sym.SC); }
//"->"          {return sym(sym.ARROW); }
"-"		    {return sym(sym.MINUS); }
//"+"		    {return sym(sym.PLUS); }
//"/"		    {return sym(sym.DIV); }
//"*"		    {return sym(sym.STAR); }
//"("		    {return sym(sym.OB); }
//")"		    {return sym(sym.CB); }
","		    {return sym(sym.C); }
//"."		    {return sym(sym.D); }
//":"		    {return sym(sym.DD); }
//"=="		    {return sym(sym.DEQ); }
//"="		    {return sym(sym.EQ); }

"euro"       {return sym(sym.EURO_WORD); }
"%"          {return sym(sym.PERC_WORD); }

{sep}       {return sym(sym.SEP); }
{token1}    {return sym(sym.TOKEN1); }
{token2}    {return sym(sym.TOKEN2); }
{token3}    {return sym(sym.TOKEN3); }

{q_string}	    {return sym(sym.QSTRING, new String(yytext())); }
{unsigned_int}	{return sym(sym.UINT, new Integer(yytext())); }
{real_number}	{return sym(sym.RNUMBER, new Float(yytext())); }


{comment} 	{;}
\r | \n | \r\n | " " | \t	{;}
.			{ System.out.println("Scanner Error: " + yytext()); }
