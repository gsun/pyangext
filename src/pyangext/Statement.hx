package pyangext;

import haxe.extern.EitherType;
import python.Tuple.Tuple2;
import python.Dict;


typedef KeyWordType = EitherType<String, Tuple2<String, String>>;

@:pythonImport("pyang.statements", "Statement") 
extern class Statement implements Dynamic {
    public var top : Statement;
    public var parent : Statement;
    public var pos : Position;
    public var keyword : KeyWordType;
    public var arg : String;
    public var substmts : Array<Statement>;

    public function main_module():Statement;
    public function search(keyword:KeyWordType, ?children:Statement, ?arg:String):Array<Statement>;
    public function search_one(keyword:KeyWordType, ?arg:String, ?children:Statement):Statement;

    inline function resolve(f:String):Any {
        return Reflect.hasField(this, f)?Reflect.field(this, f):null;
    }
}