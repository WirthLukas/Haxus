import haxus.types.Event;
import haxus.math.Vector2;
using haxus.utils.ObjectTools;

class Main {
	static function main() {
		var v = new Vector2(10, 20).let(v -> 10 * v).also(v -> trace(v));
		trace(v.leftNormal());
		var n = v.normalize();
		// v.normalized();

		trace('v: $v');
		trace('n: $n with length: ${n.length}');
		// var r = new Rust();
		// r.changed += b -> trace(b);
		// r.changed += b -> trace('value changed');
		// r.foo();
	}
}

class Rust implements Event.IEventable {
	public var changed = new Event<Bool>();

	public function new() {
		
	}

	@:access(Event.invoke)
	public function foo() {
		// changed.invoke(true);
	}
}
