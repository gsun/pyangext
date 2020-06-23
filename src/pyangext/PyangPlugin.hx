package pyangext;

import python.lib.io.TextIOBase;
import python.Dict;
import pyangext.Optparse.OptParser;

@:pythonImport("pyang.plugin", "PyangPlugin") 
extern class PyangPlugin {
    public function new(?name:String);

    public var multiple_modules : Bool;
    public function add_opts(optparser:OptParser):Void;
    public function add_output_format(fmts:Dict<String, PyangPlugin>):Void;
    public function emit(ctx:Context, modules:Array<Statement>, writef:TextIOBase):Void;
    public function setup_ctx(ctx:Context):Void;
    public function setup_fmt(ctx:Context):Void;
}