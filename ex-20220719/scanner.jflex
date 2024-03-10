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
//unsigned_int = 0 | [1-9][0-9]*
real_number = ("+"|"-")?([1-9][0-9]*"."[0-9]*) | ("."[0-9]+) | (0"."[0-9]*)

sep = "%%%%"("%%")*
comment = ("(((-" ~ "-)))") | ("---".*)

token1 = "A_"({binary_num} | {word})
binary_num = 1*01*01* | 1*01*01*01*01*01*
word = {word_star}* | {word_plus}*
word_star = "*+" | "*"
word_plus = "+*" | "+"

token2 = "B_"({even_num}("*" | "$" | "+")){3}{even_num}(("*" | "$" | "+"){even_num}("*" | "$" | "+"){even_num})*
even_num = ("-"
                (3[0-2] | 2[0-9] | 1[0-9] | [1-9]))
            |
            (124[0-6] | 1[0-2][0-3][0-9])
            |
            ([1-9][0-9][0-9])
            |
            ([1-9][0-9])
            |
            ([0-9])

%%

//SCANNER
/*
";"         {System.out.println("SC: " + yytext()); }
//"->"      {System.out.println("ARROW: " + yytext()); }
"-"		    {System.out.println("MINUS: " + yytext()); }
//"+"		    {System.out.println("PLUS: " + yytext()); }
//"/"		    {System.out.println("DIV: " + yytext()); }
//"*"		    {System.out.println("STAR: " + yytext()); }
"("		    {System.out.println("OB: " + yytext()); }
")"		    {System.out.println("CB: " + yytext()); }
//"["		    {System.out.println("OS: " + yytext()); }
//"]"		    {System.out.println("CS: " + yytext()); }
","		    {System.out.println("C: " + yytext()); }
//"."		{System.out.println("D: " + yytext()); }
//":"		{System.out.println("DD: " + yytext()); }
//"="		{System.out.println("EQ: " + yytext()); }

"START"     {System.out.println("START_WORD: " + yytext()); }
"BATTERY"   {System.out.println("BATTERY_WORD: " + yytext()); }
"kWh"       {System.out.println("KWH_WORD: " + yytext()); }
"FUEL"      {System.out.println("FUEL_WORD: " + yytext()); }
"liters"    {System.out.println("LITERS_WORD: " + yytext()); }
"PLUS"      {System.out.println("PLUS_WORD: " + yytext()); }
"STAR"      {System.out.println("STAR_WORD: " + yytext()); }
"MAX"       {System.out.println("MAX_WORD: " + yytext()); }
"MOD"       {System.out.println("MOD_WORD: " + yytext()); }
"USE"       {System.out.println("USE_WORD: " + yytext()); }
"DO"        {System.out.println("DO_WORD: " + yytext()); }
"DONE"      {System.out.println("DONE_WORD: " + yytext()); }
"km"        {System.out.println("KM_WORD: " + yytext()); }
"units/km"  {System.out.println("UNITSKM_WORD: " + yytext()); }

{sep}       {System.out.println("SEP: " + yytext()); }
{token1}    {System.out.println("TOKEN1: " + yytext()); }
{token2}    {System.out.println("TOKEN2: " + yytext()); }

{q_string}	        {System.out.println("QSTRING: " + yytext()); }
//{unsigned_int}	    {System.out.println("UINT: " + yytext()); }
{real_number}	    {System.out.println("RNUMBER: " + yytext()); }
*/

//SCANNER + PARSER
";"		    {return sym(sym.SC); }
//"->"      {return sym(sym.ARROW); }
"-"		    {return sym(sym.MINUS); }
//"+"		    {return sym(sym.PLUS); }
//"/"		    {return sym(sym.DIV); }
//"*"		    {return sym(sym.STAR); }
"("		    {return sym(sym.OB); }
")"		    {return sym(sym.CB); }
//"["		    {return sym(sym.OS); }
//"]"		    {return sym(sym.CS); }
","		    {return sym(sym.C); }
//"."		{return sym(sym.D); }
//":"		{return sym(sym.DD); }
//"="		{return sym(sym.EQ); }

"START"     {return sym(sym.START_WORD); }
"BATTERY"   {return sym(sym.BATTERY_WORD); }
"kWh"       {return sym(sym.KWH_WORD); }
"FUEL"      {return sym(sym.FUEL_WORD); }
"liters"    {return sym(sym.LITERS_WORD); }
"PLUS"      {return sym(sym.PLUS_WORD); }
"STAR"      {return sym(sym.STAR_WORD); }
"MAX"       {return sym(sym.MAX_WORD); }
"MOD"       {return sym(sym.MOD_WORD); }
"USE"       {return sym(sym.USE_WORD); }
"DO"        {return sym(sym.DO_WORD); }
"DONE"      {return sym(sym.DONE_WORD); }
"km"        {return sym(sym.KM_WORD); }
"units/km"  {return sym(sym.UNITSKM_WORD); }

{sep} 	  {return sym(sym.SEP); }
{token1}  {return sym(sym.TOKEN1); }
{token2}  {return sym(sym.TOKEN2); }

{q_string} {return sym(sym.QSTRING, yytext()); }
//{unsigned_int}	{return sym(sym.UINT, new Integer(yytext())); }
{real_number}  {return sym(sym.RNUMBER, new Float(yytext())); }

{comment} {;}
\r | \n | \r\n | " " | \t	{;}
.				{ System.out.println("Scanner Error: " + yytext()); }
