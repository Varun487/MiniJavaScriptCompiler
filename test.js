// /*
// 	Multiline comments -> BUG
// */

// test comment;
// 1 // syntax error
// console.log(0) // testing in line comment after a statement -> BUG

// testing logging numbers
console.log(0);
console.log(12)
console.log(132415.123456789);
console.log(132415.123)
console.log(-1);
console.log(-123);
console.log(-123.123456);

// testing 2 inline statements
console.log(1); console.log(2);
console.log(3); console.log(4)
// console.log(0) console.log(12); // syntax error

// testing logging strings
console.log("hello")
console.log("");
console.log('hi');
console.log('');

// Print some key words
console.log(true); console.log(false);
console.log(undefined)
console.log(null);

// Evaluate special characters in string, Produce error when string not completed properly -> BUG
console.log("special characters: !@#$%^&*()<>/':-_+=\n\t"stringisnotdone")

// variable assignment
var abc = 1;
var a = 2
var def = "hello";
a = 3
var diff = "new";
var t = true
t = false;
var n = null
var back = undefined;

// print variable
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

// math expressions
1 + 3
1 - 3;
1 * 3
1 / 3;
1 % 3

console.log(1 + 3);
console.log(1 - 3);
console.log(1 * 3);
console.log(1 / 3);
console.log(1 % 3);

console.log(1 + 3 - 2);
console.log(2 * 2 - 1);

var test = 1;
console.log(test);
test++
console.log(test);
test--
console.log(test);
test += 3;
console.log(test);
test -= 3;
console.log(test);
test *= 3;
console.log(test)
test /= 3;
console.log(test)
test %= 3;
console.log(test)
test = 4

// boolean expressions
1 == 3
1 < 3
1 <= 3
1 > 3
1 >= 3

test == 3
3 == test;
test == abc
test < 3
test <= 3
test > 3

// for loop test

var i = 0;

for ( i = 0; i < 3; i++) { console.log(i); }

for ( i = 0; i < 3; i++) { 
	console.log(test);
}

for ( i = 0; i < 3; i++)
{ 
	console.log(3); 
}

// for ( i = 0; i < 3; i++)

// 	console.log(3); 
// }

// While loop test

var j = 0;

while (j < 3) { console.log(j); j++; }

while (j < 3) { 
	console.log(j); 
	j++; 
}

while (j < 3) 
{
	console.log(j);
	j++;
}

// while j < 3 {
// 	console.log(j);
// }
