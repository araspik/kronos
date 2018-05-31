/**** Conversion between C and D string types.
	* 
	* This module provides conversion methods for converting to and from C string pointers, which
	* always end in '\0', and D strings, which provide a length attribute.
  * 
  * Date: 30 May 2018
  * Author: ARaspiK
  * License: MIT
  */

module drt.clc.c.string;

import drt.ctfe.traits;

/**** A type suitable for passing C strings to functions.
	* 
	* It accurately represents the C string type commonly used in C functions and is recommended
	* usage for passing C strings.
	*/
alias cStr = immutable(char)*;

/**** A converter function from D strings to C strings.
	* 
	* It takes a D string and converts it to a C string, via memory allocation, copying, and appending
	* a '\0'.
	* 
	* Implementation Note:
	* As a '\0' is appended to the end of the string, it is necessary that the string be copied. This
	* does involve memory allocation, which must be explicitly handled.
	*/
@nogc @safe T to(T : cStr, F)(F str) pure nothrow if (isString!F) {
	import drt.malloc: alloc;
	import drt.memops: memcpy;

	// Allocate str.length + 1 space
	string res = alloc!string(str.length + 1);
	// Copy str into res
	res.memcpy(str);
	// Add '\0' at end
	res[$-1] = '\0';

	// Return ptr
	return res.ptr;
}

/**** A convert function from C strings to D strings.
	* 
	* It is simply a wrapper around cStrLen, and returns C string as a D string by slicing into the
	* pointer.
	*/
@nogc @safe T to(T : string, F : cStr)(F str) pure nothrow {
	return str[0 .. strLen(str)];
}

/**** A string length retreiver function.
	* 
	* It returns the length of the C string, or the index in the C string where the first '\0'  can be
	* found.
	*/
@nogc @safe size_t strLen(cStr str) pure nothrow {
	cStr ptr = str;
	while (*ptr != '\0') ptr++;
	return ptr - str;
}
