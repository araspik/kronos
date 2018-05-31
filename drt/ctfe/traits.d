/**** CTFE: Compile-Time Traits
	* 
	* This module provides functions for testing types and retrieving object information at compile
	* time.
  * 
  * Date: 30 May 2018
  * Author: ARaspiK
  * License: MIT
  */

module drt.ctfe.traits;

/**** Converts a series of anything to a single list type.
	* 
	* This function converts a given series of compile-time knowns and packages them together as one
	* of D's compile-time lists (occasionally misnamed tuples).
	*/
alias AliasSeq(T...) = T;

private {
	enum sInts = AliasSeq!(byte, short, int, long);
	enum uInts = AliasSeq!(ubyte, ushort, uint, ulong);
	enum ints = AliasSeq!(sInts, uInts);
}

/**** Returns a boolean for whether the given type is an unsigned integral.
	* 
	* This template compares the given type to a list of types of builtin unsigned integers and
	* returns true if it finds a match.
	*/
enum isUnsigned(T) = is(T == ubyte) || is(T == ushort) || is(T == uint) || is(T == ulong);

/**** Returns a boolean for whether the given type is a signed integral.
	* 
	* This template compares the given type to a list of types of builtin signed integers and returns
	* true if it finds a match.
	*/
enum isSigned(T) = is(T == byte) || is(T == short) || is(T == int) || is(T == long);

/**** Returns a boolean for whether the given type is an integral.
	* 
	* This template compares the given type to a list of types of builtin integers and retruns true if
	* it finds a match.
	*/
enum isIntegral(T) = isUnsigned!T || isSigned!T;
