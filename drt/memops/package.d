/**** Memory operation functions package.
	* 
	* Provides freely usable memory operations, all naturally independent of the kernel.
	* 
	* 
  * Date: 30 May 2018
  * Author: ARaspiK
  * License: MIT
  */

module drt.memops;

public import
		drt.memops.memcpy,
		drt.memops.memcmp,
		drt.memops.memset,
		drt.memops.memmov;
