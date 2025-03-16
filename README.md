# command_line_calc

Install Required Dependencies
`sudo apt update && sudo apt install -y bison flex gcc make build-essential`


1) Get these files on your pc
2) Compile : `bison -d calc.y`
3) Compile :  `flex calc.l`
4) Compile : `gcc lex.yy.c calc.tab.c -o calc -lm`
5) Run : `./calc`

Input expressions like 
(2+3*5) or sin(30)
