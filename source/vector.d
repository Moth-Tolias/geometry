/**
* Types and functions pertaining to euclidian vectors.
* Authors: Susan
* Date: 2021-09-12
* Licence: AGPL-3.0 or later
* Copyright: Hybrid Development Team, 2021
*/

module geometry.vector;

/// 2d vector. T can be any numeric type.
struct Vector2(T)
{
	import std.traits;
	static assert(isNumeric!T);
	static assert(__traits(isPOD, Vector2!T));

	T x; /// X and Y components.
	T y; /// ditto

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

	/// Vector addition, subtraction, and multiplication.
	auto inout opBinary(string op, V : Vector2!T, T)(in V rhs) pure @safe @nogc nothrow
	{
		static if (op != "+" && op != "-" && op != "*" && op != "/")
		{
			static assert(false, "not yet implemented");
		}

		mixin(
			"Vector2!(typeof(x " ~ op ~ " rhs.x)) result;
			result.x = x " ~ op ~ " rhs.x;
			result.y = y " ~ op ~ " rhs.y;
			return result;"
		);
	}

	/// Scalar multiplication.
	auto inout opBinary(string op, U)(in U rhs) pure @safe @nogc nothrow
	{
		static assert(isNumeric!U);
		static if ( op != "*" && op != "/")
		{
			static assert(false, "not yet implemented");
		}

		mixin(
			"Vector2!(typeof(x " ~ op ~ " rhs)) result;
			result.x = x " ~ op ~ " rhs;
			result.y = y " ~ op ~ " rhs;
			return result;"
		);
	}

	/// ditto
	void opOpAssign(string op, U)(in U rhs) pure @safe @nogc nothrow
	{
		static assert(isNumeric!U);
		static if ( op != "*" && op != "/")
		{
			static assert(false, "not yet implemented");
		}

		mixin(
			"x = x " ~ op ~ " rhs;
			y = y " ~ op ~ " rhs;"
		);
	}

	/// Casts a 2d vector from one type to another.
	auto inout opCast(V : Vector2!T, T)() pure @safe @nogc nothrow const
	{
		return (V(x, y));
	}
}
