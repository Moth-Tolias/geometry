/**
* Rectangles, and functions pertaining to them.
* Authors: Susan
* Date: 2021-09-12
* Licence: AGPL-3.0 or later
* Copyright: Hybrid Development Team, 2022
*/
module geometry.rectangle;

import geometry.line;
import geometry.vector;
import std.traits: isNumeric;

///
struct Rectangle(T)
if(isNumeric!T)
{
	Vector2!T position; ///
	Vector2!T size; /// rectangles may have sizes of zero, but may never be negative.

	invariant (size.x >= 0 && size.y >= 0);

	@property ref x() inout => position.x; ///
	@property ref y() inout => position.y; ///
	@property ref width() inout => size.x; ///
	@property ref height() inout => size.y; ///

	alias w = width; ///
	alias h = height; ///

	private alias LineType = typeof(T + T);
	auto up() const => Line!LineType(cast(Vector2!LineType)position, Vector2!LineType(x + width, y));
	auto down() const => Line!LineType(Vector2!LineType(x, y + height), Vector2!LineType(x + width, y + height));
	auto left() const => Line!LineType(cast(Vector2!LineType)position, Vector2!LineType(x, y + height));
	auto right() const => Line!LineType(Vector2!LineType(x + width, y), Vector2!LineType(x + width, y + height));
}

///
bool pointInRectangle(R : Rectangle!(T), T, V)(in R r, in Vector2!(V) point) @nogc nothrow pure @safe
{
	return ((point.x >= r.x) && (point.x < (r.x + r.w))) && ((point.y >= r.y) && (point.y < (r.y + r.h)));
}

///
bool pointInRectangle(S, V)(in Vector2!S size, in Vector2!(V) point) @nogc nothrow pure @safe
{
	immutable zero = Vector2!S (0, 0); //todo: zero, one
	immutable r = Rectangle!S (zero, size);
	return pointInRectangle(r, point);
}

///
@safe @nogc nothrow unittest
{
	immutable r = Rectangle!int(Vector2!(int)(0), Vector2!(int)(3));

	assert(!r.pointInRectangle(Vector2!(int)(-1)));
	assert(r.pointInRectangle(Vector2!(int)(0)));
	assert(r.pointInRectangle(Vector2!(ubyte)(2)));
	assert(!r.pointInRectangle(Vector2!(int)(3)));

	assert(!pointInRectangle(Vector2!(int)(0), Vector2!(int)(-1)));
	assert(!pointInRectangle(Vector2!(int)(0), Vector2!(int)(0)));
	assert(!pointInRectangle(Vector2!(int)(0), Vector2!(ubyte)(1)));

	immutable r2 = Rectangle!ubyte(Vector2!(ubyte)(0, 3), Vector2!(ubyte)(3, 4));
	assert(r2.up == Line!ubyte(Vector2!ubyte(0, 3), Vector2!ubyte(3, 3)));
	assert(r2.down == Line!ubyte(Vector2!ubyte(0, 7), Vector2!ubyte(3, 7)));
	assert(r2.left == Line!ubyte(Vector2!ubyte(0, 3), Vector2!ubyte(0, 7)));
	assert(r2.right == Line!ubyte(Vector2!ubyte(3, 3), Vector2!ubyte(3, 7)));
}
