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
	Vector2!(T) start; ///
	Vector2!(T) end; ///

	//static Vector2!(float) nearestPoint(Line line, Vector2!(float) a)
	//{
	//
	//}

	///
	bool opEquals(L: Line!U, U)(in L rhs) pure @safe @nogc nothrow const
	{
		//todo: should lines really be directionless?
		return ((start == rhs.start) && (end == rhs.end)) || ((start == rhs.end) && (end == rhs.start));
	}

	///
	size_t toHash() pure @safe @nogc nothrow const
	{
		return cast(size_t)(start.toHash + end.toHash);
	}
}

@nogc nothrow pure @safe unittest
{
	Line!int line;
	line.start.x = 69;

	static assert(__traits(isPOD, Line!int));
}
