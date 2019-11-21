package pyangext;

import haxe.extern.EitherType;
import python.Tuple.Tuple2;
import python.Dict;

@:pythonImport("pyang.statements", "Statement") 
extern class Statement {
    public var top : Statement;
    public var parent : Statement;
    public var pos : Position;
    public var keyword : EitherType<String, Tuple2<String, String>>;
    public var arg : String;
    public var substmts : Array<Statement>;

    public var i_config : Bool;
    public var i_module : ModSubmodStatement;
    public var i_orig_module : ModSubmodStatement;
    public var i_modulename : String;
    
    public var i_children : Array<Statement>;
    public var i_extension : Statement;

    public function main_module():Statement;
    public function search(keyword:String, ?children:Statement, ?arg:String):Array<Statement>;
    public function search_one(keyword:String, ?arg:String, ?children:Statement):Statement;
}