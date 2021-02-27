// Testing the lexical analyzer
// number datatype must include . and are analogous to double in c
// convert string to numbers and return in case of number token
// Consume comments, if a file ends with comments, return error
// Evaluate complex math expressions
// Objects?
// Dot notation?
// Fix multiline comments
// Update yylval, yylloc and return token code for each token
// The yylval global variable is used to record the value for each lexeme scanned and
// the yylloc global records the lexeme position (line number and column). 
// The action for each pattern will update the global variables and return the appropriate token code.

// comment test
1
12341.2312343
"hello"
console.log(1);
console.log(100)
console.log("hello world");
console.log(null)
console.log(undefined);
true
false;
abc
var abc;
console.log(abc)
var a = 12 + (3 - 4);
