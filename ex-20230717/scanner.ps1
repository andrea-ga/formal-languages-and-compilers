[CmdletBinding()]
param()

$lexerFile = "scanner.jflex"
$textFile = "20230717_flc.txt"

jflex $lexerFile

javac Lexer.java

java Lexer $textFile
