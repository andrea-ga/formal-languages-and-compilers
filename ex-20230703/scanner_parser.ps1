[CmdletBinding()]
param()

$scannerFile = "scanner.jflex"
$textFile = "example.txt"

jflex $scannerFile

java java_cup.Main parser.cup

javac Yylex.java sym.java parser.java Main.java

java Main $textFile
