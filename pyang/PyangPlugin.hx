package pyang;

import python.lib.io.IOBase;
import python.Dict;

@:pythonImport("pyang.plugin", "PyangPlugin") 
extern class PyangPlugin {
    public function add_opts(optparser:OptionParser);
    public function add_output_format(fmts:Dict<String, PyangPlugin>);
    public function emit(ctx:Context, modules:Array<Statement>, writef:IOBase);
    public function setup_ctx(ctx:Context);
    public function setup_fmt(ctx:Context);
}