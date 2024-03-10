[CmdletBinding()]
param()

$lexerFile = "scanner.jflex"
$textFile = "20220916_flc.txt"

jflex $lexerFile

javac Lexer.java

java Lexer $textFile
