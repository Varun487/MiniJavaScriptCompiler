# Mini Compiler for JavaScript

Implementing a ```mini compiler``` that takes as input a JavaScript program (with focus on the programming construct for loop statements) and produces an optimized intermediate code as an output.

# What is the project about?

This project uses ```yacc``` and ```lex``` to generate a mini compiler for JavaScript. A ```mini compiler``` performs lexical analysis, symbol table generation and syntax validation. This project intends to manage assignments, datatypes, evaluate expressions and emulate loops in javascript.

# To replicate this project on your computer
1. To initalize the project:
```
git clone git@github.com:Varun487/MiniJavaScriptCompiler.git

cd MiniJavaScriptCompiler

make

```
2. To compile and run a program:
```

./jscompiler < test.js

```

# Project members

###### All members are from Semester 6 Section E Pes University EC Campus

1. Varun Seshu - PES2201800074
2. Sneha Jain A - PES2201800030
3. Bhavan Naik - PES2201800047

# TODO
	- Lexical Analysis and Token Generation
		- Conversion of strings to numbers
		- Multiline comments - if a file ends with comments, return error
		- Evaluate complex math expressions
		- Objects?
		- Dot notation?
		- Update yylval, yylloc, other global variables (line and col nums) and return token code for each action
		- Record the line number and first and last column in yylloc for all tokens
		- Report lexical errors for improper strings, lengthy identifiers, and invalid characters
		- For each character that cannot be matched to any token pattern, report it and continue parsing with the next character.
		- If a string erroneously contains a newline, report an error and continue at the beginning of the next line.
		- If an identifier is longer than the maximum (31 characters), report the error, truncate the identifier to the first 31 characters (discarding the rest), and continue.
	- Symbol Table generation
	- CFG
	- Parsing: syntax validation 
