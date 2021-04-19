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
- Intermediate code generation ![FEATUREINCOMPLETE]
	- For loop intermediate code ![INCOMPLETE]
		- Quadruple format ![INCOMPLETE]
		- Symbol table entries for all temp var ![INCOMPLETE]
			- Print symbol table ![INCOMPLETE]
	- While loop intermediate code ![INCOMPLETE]
	- Catch semantic errors in program ![INCOMPLETE]
		- 2 errors at least ![INCOMPLETE]
	- README to explain design decisions and semantic errors ![INCOMPLETE]
- Code Optimization ![FEATUREINCOMPLETE]
- Final report ![DOCINCOMPLETE]

[DONE]: https://img.shields.io/badge/DONE-brightgreen
[INCOMPLETE]: https://img.shields.io/badge/INCOMPLETE-red
[BUG]: https://img.shields.io/badge/BUG-red
[BUGFIXED]: https://img.shields.io/badge/BUG-FIXED-brightgreen
[FEATUREINCOMPLETE]: https://img.shields.io/badge/FEATURE-INCOMPLETE-red
[FEATURECOMPLETE]: https://img.shields.io/badge/FEATURE-COMPLETE-brightgreen
[MEETINGINCOMPLETE]: https://img.shields.io/badge/MEETING-INCOMPLETE-red
[DOCINCOMPLETE]: https://img.shields.io/badge/DOC-INCOMPLETE-red
[DOCCOMPLETE]: https://img.shields.io/badge/DOC-COMPLETE-brightgreen
