/**** Basic required D code available to all.
  * 
  * Date: 29 May 2018
  * Author: ARaspiK
  * License: MIT
  */

module object;

/**** The size type.
  * 
  * It provides an adequate type for representing sizes on the current machine.
  */
alias size_t = typeof(ulong.sizeof);

/**** The pointer difference type.
	* 
	* It provides an adequate type for representing the difference between two pointers.
	* It might not be a pointer type.
	*/
alias ptrdiff_t = typeof(cast(void*)0 - cast(void*)0);

/**** The UTF-8 string type.
  * 
  * It provides the normal type for literal strings.
	* It is the primary type for string-related operations.
	*/
alias string = immutable(char)[];

/**** The UTF-16 string type.
	* 
	* It can be used as a string that is parsed automatically as UTF-16.
	*/
alias wstring = immutable(wchar)[];

/**** The UTF-32 string type.
	* 
	* It can be used as a string that is parsed automatically as UTF-32.
	*/
alias dstring = immutable(dchar)[];


/**** Internal function that handles array casting based on size.
	* 
	* Casting between array types is automagically replaced by this function.
	* It adjusts the length of the array to match what it needs to be for the result.
	* 
	* Params:
	*		tLen = length of output type
	*		fLen = length of input type
	*		arr  = array to convert
	*/
extern(C) @trusted @nogc void[] _d_arraycast(size_t tLen, size_t fLen, void[] arr) nothrow pure {
	auto len = arr.length * fLen;
	assert(len % tLen == 0, "Array casting failed (bad type lengths)!");
	return arr[0 .. len / tLen];
}

/**** Internal function to copy one array to another.
	* 
	* It utilizes memcpy to directly copy each byte of memory from one array to the other.
	* 
	* Note that it is does not break on overlapping only if the memcpy supports overlapping.
	* Otherwise, you're screwed.
	* 
	* Params:
	*		size = size of type
	*		src  = source array
	*		dst  = destination array
	*/
extern(C) @trusted @nogc void[] _d_arraycopy(size_t size, void[] src, void[] dst) nothrow pure {
	import drt.memops: memcpy;

	((src.ptr)[0 .. src.length * size]).memcpy(dst.ptr);

	return dst;
}

/// Required by the D compiler, but quite useless.
class TypeInfo {}
/// ditto
class TypeInfo_Class: TypeInfo {}
/// ditto
class TypeInfo_Interface: TypeInfo {}
/// ditto
class TypeInfo_Struct: TypeInfo {}
/// ditto
class TypeInfo_Pointer: TypeInfo {}
/// ditto
class TypeInfo_Array: TypeInfo {}
/// ditto
class TypeInfo_StaticArray: TypeInfo {}
/// ditto
class TypeInfo_AssociativeArray: TypeInfo {}
/// ditto
class TypeInfo_Enum: TypeInfo {}
/// ditto
class TypeInfo_Function: TypeInfo {}
/// ditto
class TypeInfo_Delegate: TypeInfo {}
/// ditto
class TypeInfo_Tuple: TypeInfo {}
/// ditto
class TypeInfo_Const: TypeInfo {}
/// ditto
class TypeInfo_Invariant: TypeInfo {}
/// ditto
class TypeInfo_Shared: TypeInfo {}
/// ditto
class TypeInfo_Vector: TypeInfo {}
/// ditto
class TypeInfo_Inout: TypeInfo {}
/// ditto
class __cpp_type_info_ptr {}
