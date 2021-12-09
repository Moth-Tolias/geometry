/**
* Angles, and functions pertaining to them.
* Authors: Susan
* Date: 2021-09-12
* Licence: AGPL-3.0 or later
* Copyright: Hybrid Development Team, 2021
*/

module geometry.angle;

import std.math : PI;
alias pi = PI;
auto tau = (pi * 2); ///the better circle constant

///representation of an angle in degrees, with zero facing right.
struct Angle
{
	private float value = 0;

	enum Max = 360; ///maximum possible value for an angle in degrees.

	private enum Min = 0;
	private enum Range = (Max - Min);
	private enum Midpoint = Max - (Range / 2);

	invariant()
	{
		import std.math : isNaN;
		assert(!isNaN(value));
		assert(value >= Min);
		assert(value <= Max);
	}

	///
	float opCmp(ref const Angle target) const pure nothrow @nogc @safe
	out(r; r >= -Midpoint)
	out(r; r <= Midpoint)
	{
		return cycle(value - target.value, -Midpoint, Midpoint);
	}
}

/**
* converts a value in degrees to a value in radians.
* Returns: the same value in radians.
*/
static float degToRad(in float degrees) pure nothrow @nogc @safe
{
	return (degrees * pi) / 180;
}

/**
* converts a value in radians to a value in degrees.
* Returns: the same value in degrees.
*/
static float radToDeg(in float radians) pure nothrow @nogc @safe
{
	return (radians * 180) / pi;
}

private float cycle(in float value, in float min, in float max) pure nothrow @nogc @safe
in(min < max)
out(r; r >= min)
out(r; r <= max)
{
	immutable float range = max - min;
	float delta  = (value - min) % range;
	if (delta < 0) { delta += range; }
	return delta + min;
}

@safe unittest
{
	static assert(__traits(isPOD, Angle));

	static assert(radToDeg(pi) == 180);
	static assert(degToRad(180) == pi);

	Angle angle;

	import std.math : isNaN;
	assert(!isNaN(angle.value));
}

@safe unittest
{
	Angle a = { 90 };
	Angle b = { 45 };
	assert(a > b);

	a.value = (45);
	b.value = (360 - 45);
	assert(a > b);

	a.value = (270);
	b.value = (45);
	assert(a < b);

	//a.value = Angle.degToRad(0);
	//b.value = Angle.degToRad(360);
	//assert (a == b);
}

