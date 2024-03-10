[CmdletBinding()]
param()

$scannerFile = "scanner.jflex"
$textFile = "20221021_flc.txt"

jflex $scannerFile

java java_cup.Main parser.cup

javac Yylex.java sym.java parser.java Main.java

java Main $textFile
