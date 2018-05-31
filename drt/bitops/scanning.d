/**** Bit scanning operation intrinsics.
	* 
	* Provides functions to scan integers of architecture-supported sizes for set bits.
	* 
  * Date: 31 May 2018
  * Author: ARaspiK
  * License: MIT
  */

module drt.bitops.scanning;

import drt.ctfe.traits: isIntegral;

enum BitScanDirection {
	forward,
	backward,
}

@nogc @safe T bitScan(BitScanDirection direction, T)(T num) pure nothrow if (isIntegral!T) {
	T res; // BSF/BSR output size is same as input size

	static if (direction == BitScanDirection.forward) {
		asm @trusted @nogc pure nothrow {
			"bsf %[n], %[r]" : [r] "=r" res : [n] "rm" num : "cc";
		}
	} else {
		asm @trusted @nogc pure nothrow {
			"bsr %[n], %[r]" : [r] "=r" res : [n] "rm" num : "cc";
		}
	}

	return res;
}
