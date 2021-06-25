module geometry.rectangle;
import geometry.vector;

struct Rectangle
{
	Vector2!(int) position;
	Vector2!(int) size;

	//TODO: d properties aren't  properly supported yet
	@safe nothrow pure int x() const { return position.x; }
	@safe nothrow void x(in int val) { position.x = val; }

	@safe nothrow pure int y() const { return position.y; }
	@safe nothrow void y(int val) { position.y = val; }

	@safe nothrow pure int w() const  { return size.x; }
	@safe nothrow void w(int val) { size.x = val; }

	@safe nothrow pure int h() const { return size.y; }
	@safe nothrow void h(int val) { size.y = val; }

	alias width = w;
	alias height = h;

}

static bool pointInRectangle(in Rectangle r, in Vector2!(int) point) pure @safe nothrow
{
	return ((point.x >= r.x) && point.x <= r.x + r.w) && ((point.y >= r.y) && point.y <= r.y + r.h);
}

unittest
{
	immutable auto r = Rectangle(Vector2!(int)(0), Vector2!(int)(32));
	assert(r.pointInRectangle(Vector2!(int)(16)));
	assert(r.pointInRectangle(Vector2!(int)(0)));
	assert(r.pointInRectangle(Vector2!(int)(32)));

	assert(! r.pointInRectangle(Vector2!(int)(-16)));
}

