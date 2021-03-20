package haxus.types;

abstract Event<T>(Array<T -> Void>) {
    public inline function new() {
        this = [];
    }

    @:op(A += B)
    public inline function add(listener: T -> Void) {
        this.push(listener);
    }

    @:op(A -= B)
    public inline function remove(listener: T -> Void) {
        this.remove(listener);
    }

    @:allow(IEventable)
    private function invoke(data: T) {
        for (listener in this)
            listener(data);
    }
}

interface IEventable {
    
}
