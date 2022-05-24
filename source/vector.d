/**
* Types and functions pertaining to euclidian vectors.
* Authors: Susan
* Date: 2021-09-12
* Licence: AGPL-3.0 or later
* Copyright: Hybrid Development Team, 2022
*/

module geometry.vector;

import geometry.angle;
import std.traits;

/// 2d vector. T can be any numeric type.
struct Vector2(T)
if(isNumeric!T)
{
	static assert(__traits(isPOD, Vector2!T));

	T x; /// X and Y components.
	T y; /// ditto

	/// length of vector.
	@property float length() pure @safe @nogc nothrow const
	{
		import std.math : sqrt;
		return sqrt(cast(float) (x * x) + (y * y));
	}

	/// direction of vector.
	@property Angle direction() pure @safe @nogc nothrow const
	{
		return Angle(0); //fixme
	}

	/**
	* Returns: a 2d vector.
	* Params:
	*	x = the X component
	*	y = the Y component
	*/
	this(in T x, in T y)
	{
		this.x = x;
		this.y = y;
	}

	/**
	* Returns: a 2d vector with both the X and Y components set to xy.
	*/
	this(in T xy)
	{
		x = xy;
		y = xy;
	}

	/// Vector addition, subtraction, and scaling.
	auto inout opBinary(string op, V: Vector2!T, T)(in V rhs) pure @safe @nogc nothrow
	{
		static if (op != "+" && op != "-" && op != "*" && op != "/")
		{
			static assert(false, "not yet implemented");
		}

		mixin("Vector2!(typeof(x " ~ op ~ " rhs.x)) result;
			result.x = x " ~ op ~ " rhs.x;
			result.y = y " ~ op ~ " rhs.y;
			return result;");
	}

	/// ditto
	void opOpAssign(string op, V: Vector2!U, U)(in V rhs) pure @safe @nogc nothrow
	{
		static if (op != "+" && op != "-" && op != "*" && op != "/")
		{
			static assert(false, "not yet implemented");
		}

		mixin("x = cast(T)(x " ~ op ~ " rhs.x);
			y = cast(T)(y " ~ op ~ " rhs.y);");
	}

	/// Scalar multiplication.
	auto inout opBinary(string op, U)(in U rhs) pure @safe @nogc nothrow
	if(isNumeric!U)
	{
		static if (op != "*" && op != "/")
		{
			static assert(false, "not yet implemented");
		}

		mixin("Vector2!(typeof(x " ~ op ~ " rhs)) result;
			result.x = x " ~ op ~ " rhs;
			result.y = y " ~ op ~ " rhs;
			return result;");
	}

	/// ditto
	void opOpAssign(string op, U)(in U rhs) pure @safe @nogc nothrow
	if(isNumeric!U)
	{
		static if (op != "*" && op != "/")
		{
			static assert(false, "not yet implemented");
		}

		mixin("x = x " ~ op ~ " rhs;
			y = y " ~ op ~ " rhs;");
	}

	/// Casts a 2d vector from one type to another.
	auto inout opCast(V: Vector2!U, U)() pure @safe @nogc nothrow const
	{
		return (V(cast(U)x, cast(U)y));
	}

	bool opEquals(V: Vector2!U, U)(in V rhs) pure @safe @nogc nothrow const
	{
		return (x == rhs.x) && (y == rhs.y);
	}

	size_t toHash() pure @safe @nogc nothrow const
	{
		return cast(size_t)(x + y);
	}

	/// sets the vector to its corresponding unit vector.
	void normalise() @safe @nogc nothrow
	{
		immutable temp = this.normalised;
		this.x = cast(T) temp.x;
		this.y = cast(T) temp.y;
	}

	/// returns the unit vector this vector corresponds to.
	Vector2!float normalised() pure @safe @nogc nothrow const
	{
		immutable len = this.length;
		if (len == 0)
		{
			return cast(Vector2!float) this;
		}
		else
		{
			return (this / len);
		}
	}
}

/// returns the dot product of two vectors.
float dot(V: Vector2!T, T, W: Vector2!U, U)(in V lhs, in W rhs) pure @safe @nogc nothrow
{
	return (lhs.x * rhs.x) + (lhs.y * rhs.y);
}

@safe @nogc nothrow unittest
{
	immutable a = Vector2!int(69, 420);
	immutable b = Vector2!int(-10, +10);

	assert(a + b == b + a); //commutative
	assert(dot(a, b) == dot(b, a)); //similarly,

	immutable v = Vector2!int(1, 0);
	assert(v.length == 1);
	assert(dot(v, v) == 1);
}
