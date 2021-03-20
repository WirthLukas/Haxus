package haxus.math;

@:using(Vector2.Vector2Tools)
abstract Vector2(Array<Float>) from Array<Float> to Array<Float> {
    public var x(get, set): Float;
    public var y(get, set): Float;
    public var length(get, never): Float;    

    public inline function new(x: Float, y: Float) {
        this = [x, y];
    }

    public inline function toString() return '{ x=$x, y=$y }';

    private inline function get_x(): Float return this[0];
    private inline function set_x(value: Float): Float return this[0] = value;

    private inline function get_y(): Float return this[1];
    private inline function set_y(value: Float): Float return this[1] = value;

    private inline function get_length(): Float return Math.sqrt(x * x + y * y);

    @:op(A + B)
    public static inline function add(a: Vector2, b: Vector2): Vector2 return new Vector2(a.x + b.x, a.y + b.y);

    @:op(A - B)
    public static inline function sub(a: Vector2, b: Vector2): Vector2 return new Vector2(a.x - b.x, a.y - b.y);

    @:op(A * B)
    @:commutative
    public static inline function mul(v: Vector2, f: Float): Vector2 return new Vector2(v.x * f, v.y * f);

    @:op(A * B)
    public static inline function dot(a: Vector2, b: Vector2): Float return a.x * b.x + a.y + b.y;
}

class Vector2Tools {
    public static inline function leftNormal(v: Vector2): Vector2 return new Vector2(-v.y, v.x);
    public static inline function rightNormal(v: Vector2): Vector2 return new Vector2(v.y, -v.x);

    public static inline function normalize(v: Vector2): Vector2 return 1 / v.length * v;
}