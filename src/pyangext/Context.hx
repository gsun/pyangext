package pyangext;

@:pythonImport("pyang", "Context") 
extern class Context {
    public var implicit_errors : Bool;
    public var opts : Dynamic;
    public function get_module(modulename:String, ?revision:String):Statement;
}