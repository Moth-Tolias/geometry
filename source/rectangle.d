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

///
struct Rectangle(PositionType, SizeType)
if(isNumeric!PositionType && isNumeric!(SizeType))
{
	///
	mixin actAsRectangle!(PositionType, SizeType);
}

/// ditto
alias Rectangle(T) = Rectangle!(T, T);

/**
* Returns: whether a point is within the bounds of the rectangle.
* Params:
*	r = a rectangle
*	point = a 2d vector
*/
bool pointInRectangle(R : Rectangle!(T, U), T, U, V)(in R r, in Vector2!(V) point) @nogc nothrow pure @safe
{
	return ((point.x >= r.x) && (point.x <= (r.x + r.w))) && ((point.y >= r.y) && (point.y <= (r.y + r.h)));
}

/// ditto
bool pointInRectangle(S, V)(in Vector2!S size, in Vector2!(V) point) @nogc nothrow pure @safe
{
	immutable zero = Vector2!ubyte (0, 0); //todo: zero, one
	immutable r = Rectangle!(ubyte, S) (zero, size);
	return pointInRectangle(r, point);
}

///
@safe @nogc nothrow unittest
{
	immutable r = Rectangle!int(Vector2!(int)(0), Vector2!(int)(32));
	static assert(__traits(isPOD, typeof(r)));

	assert(r.pointInRectangle(Vector2!(ubyte)(16)));
	assert(r.pointInRectangle(Vector2!(int)(0)));
	assert(r.pointInRectangle(Vector2!(int)(32)));

	assert(!r.pointInRectangle(Vector2!(int)(-16)));

	immutable r2 = Rectangle!size_t(Vector2!(size_t)(0), Vector2!(size_t)(size_t.max));
	assert(r2.pointInRectangle(Vector2!(int)(ubyte.max)));

	assert(pointInRectangle(Vector2!(int)(5), Vector2!(int)(2)));
}

///allows a struct to act as, and be cast to, a rectangle.
mixin template actAsRectangle(PositionType, SizeType)
if(isNumeric!PositionType && isNumeric!(SizeType))
{
	Vector2!PositionType position; ///
	Vector2!SizeType size; /// rectangles may have sizes of zero, but may never be negative.

	invariant (size.x >= 0);
	invariant (size.y >= 0);

	/// x component of position.
	@property PositionType x() const @nogc nothrow pure @safe
	{
		return position.x;
	}

	/// ditto
	@property void x(in PositionType rhs) @nogc nothrow pure @safe
	{
		position.x = rhs;
	}

	/// y component of position.
	@property PositionType y() const @nogc nothrow pure @safe
	{
		return position.y;
	}

	/// ditto
	@property void y(in PositionType rhs) @nogc nothrow pure @safe
	{
		position.y = rhs;
	}

	/// width component of size.
	@property SizeType width() const @nogc nothrow pure @safe
	{
		return size.x;
	}

	/// ditto
	@property void width(in SizeType rhs) @nogc nothrow pure @safe
	{
		size.x = rhs;
	}

	/// ditto
	alias w = width;

	/// height component of size.
	@property SizeType height() const @nogc nothrow pure @safe
	{
		return size.y;
	}

	/// ditto
	@property void height(in SizeType rhs) @nogc nothrow pure @safe
	{
		size.y = rhs;
	}

	/// ditto
	alias h = height;

	///
	Rectangle opCast(Rectangle)() const @nogc nothrow pure @safe
	{
		return Rectangle(position, size);
	}
}

/// ditto
mixin template actAsRectangle(T)
if (isNumeric!T)
{
	///
	mixin actAsRectangle!(T, T);
}
