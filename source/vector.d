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

	T x;
	T y;

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

	auto inout opBinary(string op, V : Vector2!T, T)(in V rhs) pure @safe @nogc nothrow
	{
		static if (op != "+" && op != "-" && op != "*" && op != "/")
		{
			static assert("not yet implemented");
		}

		mixin(
			"Vector2!(typeof(x " ~ op ~ " rhs.x)) result;
			result.x = x " ~ op ~ " rhs.x;
			result.y = y " ~ op ~ " rhs.y;
			return result;"
		);
	}

	auto inout opCast(V : Vector2!T, T)() pure @safe @nogc nothrow
	{
		return (V(x, y));
	}
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

