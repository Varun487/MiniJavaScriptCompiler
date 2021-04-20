// test comment

// test console.log()
console.log();

// testing logging numbers
console.log("***PRINTING OF NUMBERS***");
console.log(0);					//prints 0
console.log(12);				//positive number 
console.log(132415.123456789);	//double
console.log(132415.123);		//float
console.log(-1);				//negative
console.log(-123);
console.log(-123.123456);		//negative float
console.log()

// testing inline statements
console.log(1); console.log(2);
console.log(3); console.log(4)
console.log()

// testing logging strings
console.log("***PRINTING OF STRINGS***");
console.log("hello")
console.log("");
console.log('hi');
console.log('');
console.log("!#@$%+-*^)");
console.log()

// Print some key words
console.log("***PRINTING OF KEY-WORDS***")
console.log(true); console.log(false);
console.log(undefined)
console.log(null);
console.log()

// Variable assignment
console.log("***VARIABLE ASSIGNMENT***")
var abc = 1;
var a = 2
var def = "hello";
a = 3
var diff = "new";
var t = true
t = false;
var n = null
var back = undefined;
console.log()

// Print the assigned variable
console.log("***PRINTING ASSIGNED VARIABLES***")
console.log(abc)
abc = 12
console.log(abc);
console.log(a);
console.log(def)
def = "bye";
console.log(def)
console.log(diff);
console.log(t);
console.log(n);
console.log(back);
console.log(doesntexist);
console.log()

// Math expressions
console.log("***PRINTING MATH EXPRESSIONS***")
// evaluated, but not logged
1 + 3
1 - 3;
1 * 3
1 / 3;
1 % 3

// logging expressions
console.log(1 + 3);
console.log(1 - 3);
console.log(1 * 3);
console.log(1 / 3);
console.log(1 % 3);
// console.log("hello" % 1);
console.log()

console.log(1 + 3 - 2);
console.log(2 * 2 - 1);
console.log()

// Increment and decrement Operations
console.log("***INCREMENT AND DECREMENT OPERATORS***")
var test = 1;
console.log(test);
console.log()

test++
console.log(test);
console.log()

test--
console.log(test);
console.log()

test += 3;
console.log(test);
console.log()

test -= 3;
console.log(test);
console.log()

test *= 3;
console.log(test)
console.log()

test /= 3;
console.log(test)
console.log()

test %= 3;
console.log(test)
console.log()

test = 4
console.log()

// Boolean expressions
console.log("***BOOLEAN EXPRESSIONS***")
1 == 3
1 < 3
1 <= 3
1 > 3
1 >= 3
console.log()

test == 3
3 == test;
// syntax error
// test == 
test < 3
test <= 3
test > 3

console.log()

// for loop test
console.log("***FOR LOOP***")
var i = 0;

for ( i = 0; i < 3; i++) { console.log(1); }
console.log()

for ( i = 1  ; i < 3; i++) { 
	console.log(1);
}
console.log()

for ( i = 2 ; i < 3; i++)
{ 
	console.log(1); 
}
console.log()

// syntax error
// for ( i = 0; i < 3; i++) { print(1); } 

// syntax error
// for ( i = 0; i < 3; i++)
// 	console.log(3); 
// }

// While loop test
console.log("***WHILE LOOP***")
var j = 0;
console.log()

while (j < 3) { console.log(j); j++; }
console.log()

while (j < 3) { 
	console.log(j); 
	j++; 
}
console.log()

while (j < 3) 
{
	console.log(j);
	j++;
}
console.log()

// syntax error
// while j < 3 {
// 	console.log(j);
// }
console.log()
