module geometry.rectangle;
import geometry.vector;

struct Rectangle(T)
{
	Vector2!T position;
	Vector2!T size;

	invariant(size.x >= 0);
	invariant(size.y >= 0);

	@property @safe @nogc nothrow pure T x() const { return position.x; }
	@property @safe @nogc nothrow void x(in T rhs) { position.x = rhs; }

	@property @safe @nogc nothrow pure T y() const { return position.y; }
	@property @safe @nogc nothrow void y(in T rhs) { position.y = rhs; }

	@property @safe @nogc nothrow pure T w() const  { return size.x; }
	@property @safe @nogc nothrow void w(in T rhs) { size.x = rhs; }

	@property @safe @nogc nothrow pure T h() const { return size.y; }
	@property @safe @nogc nothrow void h(in T rhs) { size.y = rhs; }

	alias width = w;
	alias height = h;
}

static bool pointInRectangle(R : Rectangle!(T), T)(in R r, in Vector2!(T) point) pure @safe @nogc nothrow
{
	return ((point.x >= r.x) && (point.x <= (r.x + r.w))) && ((point.y >= r.y) && (point.y <= (r.y + r.h)));
}

unittest
{
	immutable auto r = Rectangle!int(Vector2!(int)(0), Vector2!(int)(32));
	assert(r.pointInRectangle(Vector2!(int)(16)));
	assert(r.pointInRectangle(Vector2!(int)(0)));
	assert(r.pointInRectangle(Vector2!(int)(32)));

	assert(! r.pointInRectangle(Vector2!(int)(-16)));
}
