[CmdletBinding()]
param()

$lexerFile = "scanner.jflex"
$textFile = "example.txt"

jflex $lexerFile

javac Lexer.java

java Lexer $textFile
