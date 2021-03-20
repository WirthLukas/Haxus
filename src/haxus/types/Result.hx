package haxus.types;

import haxus.utils.ObjectTools;
import haxe.Exception;

@:using(Result.ResultTools)
class Result<T> {
    private var value: T;
    private var excpetion: Exception;

    public var isSuccess(get, never): Bool;
    public var isFailure(get, never):Bool;
        
    function get_isSuccess(): Bool return excpetion == null && value != null;
    function get_isFailure():Bool return !isSuccess;

    public function new(value: T, ex: Exception) {
        this.value = value;
        this.excpetion = ex;
    }

    public function getOrNull(): T return value;
    public function exceptionOrNull(): Exception return excpetion;
    public function toString(): String return isFailure ? excpetion.toString() : 'Success($value)';    

    public static function success<T>(value: T): Result<T> return new Result(value, null);
    public static function failure<T>(exception: Exception) return new Result<T>(null, exception);
}

class ResultTools {
    public static function getOrThrow<T>(result: Result<T>): T {
        if (result.isFailure)
            throw result.exceptionOrNull();

        return result.getOrNull(); 
    }

    public static function getOrElse<R, T : R>(result: Result<T>, onFailure: (ex: Exception) -> R): R {
        return result.isSuccess ? result.getOrNull() : onFailure(result.exceptionOrNull());
    }

    public static function getOrDefault<R, T : R>(result: Result<T>, defaultValue: R): R {
        return result.isFailure ? defaultValue : result.getOrNull();  
    }

    public static function fold<T, R>(result: Result<T>, onSuccess: T -> R, onFailure: Exception -> R): R {
        return (var ex = result.exceptionOrNull()) == null ? onSuccess(result.getOrNull()) : onFailure(ex);
    }

    public static function map<T, R>(result: Result<T>, transform: T -> R): Result<R> {
        return result.isSuccess ? Result.success(transform(result.getOrNull())) : new Result(null, result.exceptionOrNull());       
    }

    public static function mapCatching<T, R>(result: Result<T>, transform: T -> R): Result<R> {
        return result.isSuccess ? ObjectTools.runCatching(result.getOrNull(), transform) : new Result(null, result.exceptionOrNull());
    }
}