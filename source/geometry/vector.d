module geometry.vector;

/*struct Vector(int N = 2, T = int)
{
	import std.traits;
	static assert(N >= 0);
	static assert(isNumeric!T);
	static assert(__traits(isPOD, Vector!(N,T)));
}*/

struct Vector2(T)
{
	import std.traits;
	static assert(isNumeric!T);
	static assert(__traits(isPOD, Vector2!T));

	this(T xy)
	{
		x = xy;
		y = xy;
	}

	this(T x, T y)
	{
		this.x = x;
		this.y = y;
	}

	T x;
	T y;
}

struct Vector3(T)
{
	import std.traits;
	static assert(isNumeric!T);
	static assert(__traits(isPOD, Vector3!T));

	T x;
	T y;
	T z;
}

