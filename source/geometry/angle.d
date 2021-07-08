module geometry.angle;
import std.math : PI, isNaN;
alias pi = PI;
auto tau = (pi * 2);

float cycle(in float value, in float min, in float max) pure nothrow @nogc @safe
in(min < max)
out(r; r >= min)
out(r; r <= max)
{
	immutable float range = max - min;
	float delta  = (value - min) % range;
	if (delta < 0) { delta += range; }
	return delta + min;
}

struct Angle
{
	///in degrees, with zero facing right //TODO: change to radians?
	float value = 0;

	enum Max = 360;
	enum Min = 0;
	enum Range = (Max - Min);
	enum Midpoint = Max - (Range / 2);

	invariant()
	{
		assert(!isNaN(value));
		assert(value >= Min);
		assert(value <= Max);
	}

	float opCmp(ref const Angle target) const pure nothrow @nogc @safe
	out(r; r >= -Midpoint)
	out(r; r <= Midpoint)
	{
		return cycle(value - target.value, -Midpoint, Midpoint);
	}

	static float degToRad(in float degrees) pure nothrow @nogc @safe
	{
		return (degrees * pi) / 180;
	}

	static float radToDeg(in float radians) pure nothrow @nogc @safe
	{
		return (radians * 180) / pi;
	}

}

unittest
{
	static assert(__traits(isPOD, Angle));

	static assert(Angle.radToDeg(pi) == 180);
	static assert(Angle.degToRad(180) == pi);
}

unittest
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

