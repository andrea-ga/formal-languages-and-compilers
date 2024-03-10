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
c_style_var = [a-zA-Z_][a-zA-Z0-9_]*
//unsigned_int = 0 | [1-9][0-9]*
//real_number = ("+"|"-")?([1-9][0-9]*"."[0-9]*) | ("."[0-9]+) | (0"."[0-9]*)

sep = "$$$"
comment = "{++" ~ "++}"

token1 = "?"{up_char}{6}({up_char}{up_char})*{oct}({word}{4}({word})*)?
up_char = [A-Z]
oct = ("-"(12[0-7] | 1[01][0-7] | [1-7][0-7] | 1-7))
      |
      0
      |
      ([0-7] | [1-7][0-7] | [1-2][0-7][0-7] | 3[01][0-7] | 32[0-3])
word = "xx" | "yy" | "zz"

token2 = ({email}("!" | "/") | ({email}("!" | "/")){11} | ({email}("!" | "/")){14}){email}
email = ([a-zA-Z0-9_\.])+"@"([a-zA-Z0-9])+"."("it" | "org" | "com" | "net")

token3 = "tk3"

%%

//SCANNER
/*
";"         {System.out.println("SC: " + yytext()); }
//"->"          {System.out.println("ARROW: " + yytext()); }
//"-"		    {System.out.println("MINUS: " + yytext()); }
//"+"		    {System.out.println("PLUS: " + yytext()); }
//"/"		    {System.out.println("DIV: " + yytext()); }
//"*"		    {System.out.println("STAR: " + yytext()); }
"("		    {System.out.println("OB: " + yytext()); }
")"		    {System.out.println("CB: " + yytext()); }
"["		    {System.out.println("OS: " + yytext()); }
"]"		    {System.out.println("CS: " + yytext()); }
","		    {System.out.println("C: " + yytext()); }
//"."		    {System.out.println("D: " + yytext()); }
//":"		    {System.out.println("DD: " + yytext()); }
"="		    {System.out.println("EQ: " + yytext()); }

"OR"        {System.out.println("OR_WORD: " + yytext()); }
"AND"       {System.out.println("AND_WORD: " + yytext()); }
"NOT"       {System.out.println("NOT_WORD: " + yytext()); }
"T"         {System.out.println("T_WORD: " + yytext()); }
"F"         {System.out.println("F_WORD: " + yytext()); }
"fz_and"    {System.out.println("FZAND_WORD: " + yytext()); }
"CMP"       {System.out.println("CMP_WORD: " + yytext()); }
"WITH"      {System.out.println("WITH_WORD: " + yytext()); }
"print"     {System.out.println("PRINT_WORD: " + yytext()); }

{sep}       {System.out.println("SEP: " + yytext()); }
{token1}    {System.out.println("TOKEN1: " + yytext()); }
{token2}    {System.out.println("TOKEN2: " + yytext()); }
{token3}    {System.out.println("TOKEN3: " + yytext()); }

{q_string}	    {System.out.println("QSTRING: " + yytext()); }
{c_style_var}	{System.out.println("CVAR: " + yytext()); }
//{unsigned_int}	{System.out.println("UINT: " + yytext()); }
//{real_number}	    {System.out.println("RNUMBER: " + yytext()); }
*/

//SCANNER + PARSER

";"		    {return sym(sym.SC); }
//"->"          {return sym(sym.ARROW); }
//"-"		    {return sym(sym.MINUS); }
//"+"		    {return sym(sym.PLUS); }
//"/"		    {return sym(sym.DIV); }
//"*"		    {return sym(sym.STAR); }
"("		    {return sym(sym.OB); }
")"		    {return sym(sym.CB); }
"["		    {return sym(sym.OS); }
"]"		    {return sym(sym.CS); }
","		    {return sym(sym.C); }
//"."		    {return sym(sym.D); }
//":"		    {return sym(sym.DD); }
"="		    {return sym(sym.EQ); } 

"OR"        {return sym(sym.OR_WORD); }
"AND"       {return sym(sym.AND_WORD); }
"NOT"       {return sym(sym.NOT_WORD); }
"T"         {return sym(sym.T_WORD); }
"F"         {return sym(sym.F_WORD); }
"fz_and"    {return sym(sym.FZAND_WORD); }
"CMP"       {return sym(sym.CMP_WORD); }
"WITH"      {return sym(sym.WITH_WORD); }
"print"     {return sym(sym.PRINT_WORD); }

{sep}       {return sym(sym.SEP); }
{token1}    {return sym(sym.TOKEN1); }
{token2}    {return sym(sym.TOKEN2); }
{token3}    {return sym(sym.TOKEN3); }

{q_string}	    {return sym(sym.QSTRING, new String(yytext())); }
{c_style_var}	{return sym(sym.CVAR, new String(yytext())); }
//{unsigned_int}	{return sym(sym.UINT, new Integer(yytext())); }
//{real_number}	    {return sym(sym.RNUMBER, new Float(yytext())); }


{comment} 	{;}
\r | \n | \r\n | " " | \t	{;}
.			{ System.out.println("Scanner Error: " + yytext()); }
