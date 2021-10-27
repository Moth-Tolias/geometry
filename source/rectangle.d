/**
* Rectangles, and functions pertaining to them.
* Authors: Susan
* Date: 2021-09-12
* Licence: AGPL-3.0 or later
* Copyright: Hybrid Development Team, 2021
*/

module geometry.rectangle;
import geometry.vector;

///T can be any numeric type.
struct Rectangle(T)
{
	import std.traits;
	static assert(isNumeric!T);
	static assert(__traits(isPOD, Rectangle!T));

	Vector2!T position; ///
	Vector2!T size; ///rectangles may have sizes of zero, but may never be negative.

	invariant(size.x >= 0);
	invariant(size.y >= 0);

	/// x component of position.
	@property @safe @nogc nothrow pure T x() const
	{
		return position.x;
	}

	/// ditto
	@property @safe @nogc nothrow void x(in T rhs)
	{
		position.x = rhs;
	}

	/// y component of position.
	@property @safe @nogc nothrow pure T y() const
	{
		return position.y;
	}

	/// ditto
	@property @safe @nogc nothrow void y(in T rhs)
	{
		position.y = rhs;
	}

	/// width component of size.
	@property @safe @nogc nothrow pure T width() const
	{
		return size.x;
	}

	/// ditto
	@property @safe @nogc nothrow void width(in T rhs)
	{
		size.x = rhs;
	}

	/// ditto
	alias w = width;

	/// height component of size.
	@property @safe @nogc nothrow pure T height() const
	{
		return size.y;
	}

	/// ditto
	@property @safe @nogc nothrow void height(in T rhs)
	{
		size.y = rhs;
	}

	/// ditto
	alias h = height;
}

/**
* Returns: whether a point is within the bounds of the rectangle.
* Params:
*	r = a rectangle
*	point = a 2d vector
*/
static bool pointInRectangle(R : Rectangle!(T), T, U)(in R r, in Vector2!(U) point) pure @safe @nogc nothrow
{
	return ((point.x >= r.x) && (point.x <= (r.x + r.w))) && ((point.y >= r.y) && (point.y <= (r.y + r.h)));
}

@safe @nogc nothrow unittest
{
	immutable r = Rectangle!int(Vector2!(int)(0), Vector2!(int)(32));
	assert(r.pointInRectangle(Vector2!(ubyte)(16)));
	assert(r.pointInRectangle(Vector2!(int)(0)));
	assert(r.pointInRectangle(Vector2!(int)(32)));

	assert(! r.pointInRectangle(Vector2!(int)(-16)));

	immutable r2 = Rectangle!size_t(Vector2!(size_t)(0), Vector2!(size_t)(size_t.max));
	assert(r2.pointInRectangle(Vector2!(int)(ubyte.max)));
}
