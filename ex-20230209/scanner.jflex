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

sep = "$$$$"("$$")*
comment = "(*-" ~ "-*)"

token1 = {word}{hex_rep}
word = ("%*" | "*%" | "%%"){6, 17}
hex_rep = (({hex}"+"){2} | ({hex}"+"){5}){hex}
hex = [0-9a-fA-F]{2} | [0-9a-fA-F]{3} | [0-9a-fA-F]{6}

token2 = {date}("$" | "%"){date}("$" | "%"){date}("-"{bin_num})?
date = (2022"/"
            (
                (11"/"
                    (1[5-9] | 2[0-9] | 30)
                )
                |
                (12"/"
                    (0[1-9] | 1[024-9] | 2[0-9] | 3[01])
                )
            )
       )
       |
       (2023"/"
            (
                (01"/"
                    (0[1-9] | 1[0-9] | 2[0-9] | 3[01])
                )
                |
                (02"/"
                    (0[1-9] | 1[0-35-9] | 2[0-8])
                )
                |
                (03"/"
                    (0[1-9] | 1[0-9] | 2[0-9] | 3[01])
                )
            )
       )

bin_num = 1[01]11 |
          10[01][01][01]

%%

//SCANNER
/*
";"         {System.out.println("SC: " + yytext()); }
//"->"          {System.out.println("ARROW: " + yytext()); }
//"-"		    {System.out.println("MINUS: " + yytext()); }
//"+"		    {System.out.println("PLUS: " + yytext()); }
//"/"		    {System.out.println("DIV: " + yytext()); }
//"*"		    {System.out.println("STAR: " + yytext()); }
//"("		    {System.out.println("OB: " + yytext()); }
//")"		    {System.out.println("CB: " + yytext()); }
"["		    {System.out.println("OS: " + yytext()); }
"]"		    {System.out.println("CS: " + yytext()); }
","		    {System.out.println("C: " + yytext()); }
"."		    {System.out.println("D: " + yytext()); }
":"		    {System.out.println("DD: " + yytext()); }
//"=="          {System.out.println("DEQ: " + yytext()); }
//"="		    {System.out.println("EQ: " + yytext()); }

"EURO/kg"       {System.out.println("EUROKG_WORD: " + yytext()); }
"kg"            {System.out.println("KG_WORD: " + yytext()); }

{sep}       {System.out.println("SEP: " + yytext()); }
{token1}    {System.out.println("TOKEN1: " + yytext()); }
{token2}    {System.out.println("TOKEN2: " + yytext()); }

{q_string}	    {System.out.println("QSTRING: " + yytext()); }
{unsigned_int}	{System.out.println("UINT: " + yytext()); }
{real_number}	{System.out.println("RNUMBER: " + yytext()); }
*/

//SCANNER + PARSER

";"		    {return sym(sym.SC); }
//"->"          {return sym(sym.ARROW); }
//"-"		    {return sym(sym.MINUS); }
//"+"		    {return sym(sym.PLUS); }
//"/"		    {return sym(sym.DIV); }
//"*"		    {return sym(sym.STAR); }
//"("		    {return sym(sym.OB); }
//")"		    {return sym(sym.CB); }
"["		    {return sym(sym.OS); }
"]"		    {return sym(sym.CS); }
","		    {return sym(sym.C); }
"."		    {return sym(sym.D); }
":"		    {return sym(sym.DD); }
//"=="		    {return sym(sym.DEQ); }
//"="		    {return sym(sym.EQ); }

"EURO/kg"       {return sym(sym.EUROKG_WORD); }
"kg"            {return sym(sym.KG_WORD); }

{sep}       {return sym(sym.SEP); }
{token1}    {return sym(sym.TOKEN1); }
{token2}    {return sym(sym.TOKEN2); }

{q_string}	    {return sym(sym.QSTRING, new String(yytext())); }
{unsigned_int}	{return sym(sym.UINT, new Integer(yytext())); }
{real_number}	{return sym(sym.RNUMBER, new Float(yytext())); }


{comment} 	{;}
\r | \n | \r\n | " " | \t	{;}
.			{ System.out.println("Scanner Error: " + yytext()); }
