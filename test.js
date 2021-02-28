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

// Evaluate special characters in string, Produce error when string not completed properly -> BUG
console.log("special characters: !@#$%^&*()<>/':-_+=\n\t"stringisnotdone")
