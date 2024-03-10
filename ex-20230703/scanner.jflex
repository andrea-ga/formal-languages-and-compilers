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

sep = "$$$"("$$")*
comment = "<*" ~ "*>"

token1 = "!!!!"("!!")*({num} | (("?????")("??")*))
num = ("-"(1[02468] | [2468])) | 0 | 
      ([2468] | [1-9][02468] | 1[0-9][02468] | 2[0-7][02468] | 28[68])

token2 = {date}
date = (2023"/"
            (
                (07"/"
                    (0[2-9] | 1[0-9] | 2[0-9] | 3[01])
                )
                |
                (08"/"
                    (0[1-9] | 1[0-9] | 2[0-9] | 3[01])
                )
                |
                (09"/"
                    (0[1-9] | 1[0-9] | 2[0-9] | 30)
                )
                |
                (10"/"
                    (0[1-6])
                )
            )
       )

token3 = {hour}
hour = ((07)":"
            (
                ((3[7-9])
                    (":"(19 | 2[0-9] | 3[0-9] | 4[0-9] | 5[0-9]))?
                )
                | 
                ((4[0-9])
                    (":"(0[0-9] | 1[0-9] | 2[0-9] | 3[0-9] | 4[0-9] | 5[0-9]))?
                )
                | 
                ((5[0-9])
                    (":"(0[0-9] | 1[0-9] | 2[0-9] | 3[0-9] | 4[0-9] | 5[0-9]))?
                )
            )
       ) 
       |
       ((0[89])":"
            ([0-4][0-9]
                (":"(0[0-9] | 1[0-9] | 2[0-9] | 3[0-9] | 4[0-9] | 5[0-9]))?
            )
       )
       |
       ((1[0-9])":"
            ([0-4][0-9]
                (":"(0[0-9] | 1[0-9] | 2[0-9] | 3[0-9] | 4[0-9] | 5[0-9]))?
            )
       )
       |
       ((2[01])":"
            ([0-4][0-9]
                (":"(0[0-9] | 1[0-9] | 2[0-9] | 3[0-9] | 4[0-9] | 5[0-9]))?
            )
       )
       |
       ((22)":"
            (
                (([0-2][0-9])
                    (":"(0[0-9] | 1[0-9] | 2[0-9] | 3[0-9] | 4[0-9] | 5[0-9]))?
                )
                | 
                ((3[0-9])
                    (":"(0[0-9] | 1[0-9] | 2[0-3]))?
                )
            )
       )

%%

//SCANNER
/*
";"         {System.out.println("SC: " + yytext()); }
//"->"      {System.out.println("ARROW: " + yytext()); }
//"-"		    {System.out.println("MINUS: " + yytext()); }
//"+"		    {System.out.println("PLUS: " + yytext()); }
//"/"		    {System.out.println("DIV: " + yytext()); }
//"*"		    {System.out.println("STAR: " + yytext()); }
"("		    {System.out.println("OB: " + yytext()); }
")"		    {System.out.println("CB: " + yytext()); }
//"["		    {System.out.println("OS: " + yytext()); }
//"]"		    {System.out.println("CS: " + yytext()); }
","		    {System.out.println("C: " + yytext()); }
"."		    {System.out.println("D: " + yytext()); }
//":"		{System.out.println("DD: " + yytext()); }
"=="      {System.out.println("DEQ: " + yytext()); }
//"="		{System.out.println("EQ: " + yytext()); }

"house"       {System.out.println("HOUSE_WORD: " + yytext()); }
"start"       {System.out.println("START_WORD: " + yytext()); }
"end"         {System.out.println("END_WORD: " + yytext()); }
"if"          {System.out.println("IF_WORD: " + yytext()); }
"then"        {System.out.println("THEN_WORD: " + yytext()); }
"fi"          {System.out.println("FI_WORD: " + yytext()); }
"or"          {System.out.println("OR_WORD: " + yytext()); }
"and"         {System.out.println("AND_WORD: " + yytext()); }
"not"         {System.out.println("NOT_WORD: " + yytext()); }
"print"       {System.out.println("PRINT_WORD: " + yytext()); }

{sep}       {System.out.println("SEP: " + yytext()); }
{token1}    {System.out.println("TOKEN1: " + yytext()); }
{token2}    {System.out.println("TOKEN2: " + yytext()); }
{token3}    {System.out.println("TOKEN3: " + yytext()); }

{q_string}	    {System.out.println("QSTRING: " + yytext()); }
{unsigned_int}	{System.out.println("UINT: " + yytext()); }
{real_number}	    {System.out.println("RNUMBER: " + yytext()); }
*/
//SCANNER + PARSER

";"		    {return sym(sym.SC); }
//"->"      {return sym(sym.ARROW); }
//"-"		    {return sym(sym.MINUS); }
//"+"		    {return sym(sym.PLUS); }
//"/"		    {return sym(sym.DIV); }
//"*"		    {return sym(sym.STAR); }
"("		    {return sym(sym.OB); }
")"		    {return sym(sym.CB); }
//"["		    {return sym(sym.OS); }
//"]"		    {return sym(sym.CS); }
","		    {return sym(sym.C); }
"."		    {return sym(sym.D); }
//":"		{return sym(sym.DD); }
"=="		{return sym(sym.DEQ); }
//"="		{return sym(sym.EQ); }

"house"       {return sym(sym.HOUSE_WORD); }
"start"       {return sym(sym.START_WORD); }
"end"         {return sym(sym.END_WORD); }
"if"          {return sym(sym.IF_WORD); }
"then"        {return sym(sym.THEN_WORD); }
"fi"          {return sym(sym.FI_WORD); }
"or"          {return sym(sym.OR_WORD); }
"and"         {return sym(sym.AND_WORD); }
"not"         {return sym(sym.NOT_WORD); }
"print"       {return sym(sym.PRINT_WORD); }

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
