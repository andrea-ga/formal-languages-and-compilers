[CmdletBinding()]
param()

$lexerFile = "scanner.jflex"
$textFile = "20221021_flc.txt"

jflex $lexerFile

javac Lexer.java

java Lexer $textFile
