/**
* Lines, and functions pertaining to them.
* Authors: Susan
* Date: 2021-09-12
* Licence: AGPL-3.0 or later
* Copyright: Hybrid Development Team, 2022
*/

module geometry.line;
import geometry.vector;
import std.traits: isNumeric;

/// T can be any numeric type.
struct Line(T)
if(isNumeric!T)
{
	Vector2!(T) start; /// start of the line.
	Vector2!(T) end; /// end of the line.

	//static Vector2!(float) nearestPoint(Line line, Vector2!(float) a)
	//{
	//
	//}
}

@nogc nothrow pure @safe unittest
{
	Line!int line;
	line.start.x = 69;

	static assert(__traits(isPOD, Line!int));
}
