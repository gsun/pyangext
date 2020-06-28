package pyangext;

import haxe.extern.EitherType;
import python.Tuple.Tuple2;
import python.Dict;


typedef KeyWordType = EitherType<String, Tuple2<String, String>>;

abstract NodeId(String) from String to String {
    public var prefix(get, never):String;
    public var id(get, never):String;

    function get_prefix() {
        var idx = this.indexOf(':');
        return (idx == -1) ? null : this.substring(0, idx);
    }

    function get_id() {
        var idx = this.indexOf(':');
        return (idx == -1) ? this : this.substring(idx + 1);
    }
}

abstract SchemaNodeId(String) from String to String {
    public var absolute(get, never):Bool;
    public var path(get, never):Array<NodeId>;

    function get_absolute() {
        return (this.charAt(0) == '/') ? true : false;
    }

    function get_path() {
        var relative = absolute ? this.substring(1) : this;
        return relative.split('/');
    }
}

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
        if (Reflect.hasField(this, f)) {
            return Reflect.field(this, f);
        } else {
            return switch (f) {
            case 'i_children'|'i_uses': new Array<Statement>();
            default: null;
            };
        }
    }
}