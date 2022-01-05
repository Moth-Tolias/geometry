/**
* Lines, and functions pertaining to them.
* Authors: Susan
* Date: 2021-09-12
* Licence: AGPL-3.0 or later
* Copyright: Hybrid Development Team, 2021
*/

module geometry.line;
import geometry.vector;

/// T can be any numeric type.
struct Line(T)
{
	import std.traits;

	static assert(isNumeric!T);
	static assert(__traits(isPOD, Line!T));

	Vector2!(T) start; /// start of the line.
	Vector2!(T) end; /// end of the line.

	//static Vector2!(float) nearestPoint(Line line, Vector2!(float) a)
	//{
	//
	//}
}
