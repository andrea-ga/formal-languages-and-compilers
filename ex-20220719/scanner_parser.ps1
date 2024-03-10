[CmdletBinding()]
param()

$scannerFile = "scanner.jflex"
$textFile = "20220719_flc.txt"

jflex $scannerFile

java java_cup.Main -parser parser parser.cup

java java_cup.MainDrawTree -parser parser parser.cup

javac Yylex.java sym.java parser.java Main.java

java Main $textFile
