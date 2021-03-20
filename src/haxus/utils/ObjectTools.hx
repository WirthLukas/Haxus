package haxus.utils;

import haxe.Exception;
import haxus.types.Result;

class ObjectTools {
    public static inline function also<T>(obj: T, block: T -> Void): T {
        block(obj);
        return obj;
    }

    public static inline function let<T, R>(obj: T, block: T -> R): R return block(obj);

    public static inline function run<T>(obj: T, block: T -> Void): Void block(obj);

    public static function runCatching<T, R>(value: T, func: T -> R): Result<R>
        return try {
            Result.success(func(value));  
        } catch(e: Exception) {
            Result.failure(e);
        };    
}