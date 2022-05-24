/**
* Rectangles, and functions pertaining to them.
* Authors: Susan
* Date: 2021-09-12
* Licence: AGPL-3.0 or later
* Copyright: Hybrid Development Team, 2022
*/

module geometry.rectangle;
import geometry.vector;
import std.traits;

///T can be any numeric type.
struct Rectangle(PositionType, SizeType)
if(isNumeric!PositionType && isNumeric!(SizeType))
{
	static assert(__traits(isPOD, Rectangle!(PositionType, SizeType)));

	Vector2!PositionType position; ///
	Vector2!SizeType size; /// rectangles may have sizes of zero, but may never be negative.

	invariant (size.x >= 0);
	invariant (size.y >= 0);

	/// x component of position.
	@property @safe @nogc nothrow pure PositionType x() const
	{
		return position.x;
	}

	/// ditto
	@property @safe @nogc nothrow void x(in PositionType rhs)
	{
		position.x = rhs;
	}

	/// y component of position.
	@property @safe @nogc nothrow pure PositionType y() const
	{
		return position.y;
	}

	/// ditto
	@property @safe @nogc nothrow void y(in PositionType rhs)
	{
		position.y = rhs;
	}

	/// width component of size.
	@property @safe @nogc nothrow pure SizeType width() const
	{
		return size.x;
	}

	/// ditto
	@property @safe @nogc nothrow void width(in SizeType rhs)
	{
		size.x = rhs;
	}

	/// ditto
	alias w = width;

	/// height component of size.
	@property @safe @nogc nothrow pure SizeType height() const
	{
		return size.y;
	}

	/// ditto
	@property @safe @nogc nothrow void height(in SizeType rhs)
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
bool pointInRectangle(R : Rectangle!(T, U), T, U, V)(in R r, in Vector2!(V) point) pure @safe @nogc nothrow
{
	return ((point.x >= r.x) && (point.x <= (r.x + r.w))) && ((point.y >= r.y) && (point.y <= (r.y + r.h)));
}

/// ditto
bool pointInRectangle(S, V)(in Vector2!S size, in Vector2!(V) point) pure @safe @nogc nothrow
{
	immutable zero = Vector2!ubyte (0, 0);
	immutable r = Rectangle!(ubyte, S) (zero, size);
	return pointInRectangle(r, point);
}


alias Rectangle(T) = Rectangle!(T, T);

///allows a struct to act as, and be cast to, a rectangle.
mixin template actAsRectangle(PositionType, SizeType)
{
	Vector2!(PositionType) position;
	Vector2!(SizeType) size;

	@property x() const @safe @nogc pure nothrow
	{
		return position.x;
	}

	@property y() const @safe @nogc pure nothrow
	{
		return position.y;
	}

	@property void x(in PositionType rhs) @safe @nogc nothrow
	{
		position.x = rhs;
	}

	@property void y(in PositionType rhs) @safe @nogc nothrow
	{
		position.y = rhs;
	}

	@property w() const @safe @nogc pure nothrow
	{
		return size.x;
	}

	@property h() const @safe @nogc pure nothrow
	{
		return size.y;
	}

	@property void w(in SizeType rhs) @safe @nogc nothrow
	{
		size.x = rhs;
	}

	@property void h(in SizeType rhs) @safe @nogc nothrow
	{
		size.y = rhs;
	}

	Rectangle opCast(Rectangle)() pure @safe @nogc nothrow const
	{
		return Rectangle(position, size);
	}
}

/// ditto
mixin template actAsRectangle(T)
{
	mixin actAsRectangle!(T, T);
}

@safe @nogc nothrow unittest
{
	immutable r = Rectangle!int(Vector2!(int)(0), Vector2!(int)(32));
	assert(r.pointInRectangle(Vector2!(ubyte)(16)));
	assert(r.pointInRectangle(Vector2!(int)(0)));
	assert(r.pointInRectangle(Vector2!(int)(32)));

	assert(!r.pointInRectangle(Vector2!(int)(-16)));

	immutable r2 = Rectangle!size_t(Vector2!(size_t)(0), Vector2!(size_t)(size_t.max));
	assert(r2.pointInRectangle(Vector2!(int)(ubyte.max)));

	assert(pointInRectangle(Vector2!(int)(5), Vector2!(int)(2)));
}
