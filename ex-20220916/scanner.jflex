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

sep = "===="
comment = "(+-" ~ "-+)"

token1 = "X_"{bin_rep}
bin_num = (10 ( 1[01]0[01][01] | 0[01][01][01][01]) ) 
          | ([01]{4,6}) 
          | (1 ((01) | (1[01])))
bin_rep = ({bin_num}("*" | "+")){3} | ({bin_num}("*" | "+")){12} | ({bin_num}("*" | "+")){15}

token2 = "Y_"{words_rep}
word = ("x" | "y" | "z"){6}(("x" | "y" | "z")("x" | "y" | "z"))*
words_rep = ({word}("#" | "$") | ({word}("#" | "$")){4}){word} 

token3 = "Z_"{date}{hour}?
date = "2022""/"
		((09"/"
			(1[0-9] | 2[0-9] | 30))
		 | (1[02]"/"
			(0[1-9] | 1[0-9] | 2[0-9] | 3[0-1]))
		 | (11"/"
			(0[1-9] | 1[0-9] | 2[0-9] | 30))
		) 
       | "2023""/"
		((0[12]"/"
			(0[1-9] | 1[0-9] | 2[0-9] | 3[01]))
		 | (03"/"
			(0[1-9] | 1[0-5]))
		)
hour = ":"
		(09":"
			(1[1-9] | [2-5][0-9])
		 | 1[0-6]":"
			([0-5][0-9])
		 | 17":"
			(0[0-9] | 1[0-3])
		)


%%

//SCANNER
/*
";"         {System.out.println("SC: " + yytext()); }
//"->"      	{System.out.println("ARROW: " + yytext()); }
//"-"		    {System.out.println("MINUS: " + yytext()); }
//"+"		    {System.out.println("PLUS: " + yytext()); }
//"/"		    {System.out.println("DIV: " + yytext()); }
//"*"		    {System.out.println("STAR: " + yytext()); }
//"("		    {System.out.println("OB: " + yytext()); }
//")"		    {System.out.println("CB: " + yytext()); }
//"["		    {System.out.println("OS: " + yytext()); }
//"]"		    {System.out.println("CS: " + yytext()); }
","		    {System.out.println("C: " + yytext()); }
//"."			{System.out.println("D: " + yytext()); }
":"			{System.out.println("DD: " + yytext()); }
//"="			{System.out.println("EQ: " + yytext()); }

"km"          {System.out.println("KM_WORD: " + yytext()); }
"ELEVATION"   {System.out.println("ELEVATION_WORD: " + yytext()); }
"m"           {System.out.println("M_WORD: " + yytext()); } 
"TO"          {System.out.println("TO_WORD: " + yytext()); }
"ROUTE"       {System.out.println("ROUTE_WORD: " + yytext()); }
"kcal/km"     {System.out.println("KCALKM_WORD: " + yytext()); }

{sep}       {System.out.println("SEP: " + yytext()); }
{token1}    {System.out.println("TOKEN1: " + yytext()); }
{token2}    {System.out.println("TOKEN2: " + yytext()); }
{token3}    {System.out.println("TOKEN3: " + yytext()); }

{q_string}		{System.out.println("QSTRING: " + yytext()); }
{unsigned_int}	{System.out.println("UINT: " + yytext()); }
{real_number}	{System.out.println("RNUMBER: " + yytext()); }
*/

//SCANNER + PARSER
";"		    {return sym(sym.SC); }
//"->"      	{return sym(sym.ARROW); }
//"-"		    {return sym(sym.MINUS); }
//"+"		    {return sym(sym.PLUS); }
//"/"		    {return sym(sym.DIV); }
//"*"		    {return sym(sym.STAR); }
//"("		    {return sym(sym.OB); }
//")"		    {return sym(sym.CB); }
//"["		    {return sym(sym.OS); }
//"]"		    {return sym(sym.CS); }
","		    {return sym(sym.C); }
//"."			{return sym(sym.D); }
":"			{return sym(sym.DD); }
//"="			{return sym(sym.EQ); }

"km"          {return sym(sym.KM_WORD); }
"ELEVATION"   {return sym(sym.ELEVATION_WORD); }
"m"           {return sym(sym.M_WORD);} 
"TO"          {return sym(sym.TO_WORD); }
"ROUTE"       {return sym(sym.ROUTE_WORD); }
"kcal/km"     {return sym(sym.KCALKM_WORD); }

{sep} 	      {return sym(sym.SEP); }
{token1}      {return sym(sym.TOKEN1); }
{token2}      {return sym(sym.TOKEN2); }
{token3}      {return sym(sym.TOKEN3); }

{q_string}    	 {return sym(sym.QSTRING, yytext()); }
{unsigned_int}   {return sym(sym.UINT, new Integer(yytext())); }
{real_number}  	 {return sym(sym.RNUMBER, new Float(yytext())); }


{comment}     {; }
\r | \n | \r\n | " " | \t	{;}
.				{ System.out.println("Scanner Error: " + yytext()); }
