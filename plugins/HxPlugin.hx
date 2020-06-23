package;

import python.lib.io.TextIOBase;
import python.Dict;
import pyangext.Optparse.OptParser;
import pyangext.*;
using Lambda;

/* need ot add module function pyang_plugin_init in generated python file, 
   and call HxPlugin.pyang_plugin_init() in pyang_plugin_init. */

class HxPlugin extends PyangPlugin {
    public function new() {
        super("haxe");
    }
    override public function add_opts(optparser:OptParser) {}
    override public function add_output_format(fmts:Dict<String, PyangPlugin>) {
        multiple_modules = true;
        fmts.set("haxe", this);
    }
    override public function emit(ctx:Context, modules:Array<Statement>, writef:TextIOBase) {
        emit_tree(ctx, modules, writef);
    
    }
    override public function setup_ctx(ctx:Context) {}
    override public function setup_fmt(ctx:Context) {
        ctx.implicit_errors = false;
    }
    
    function emit_tree(ctx:Context, modules:Array<Statement>, fd:TextIOBase) {
        for (module in modules) {
			fd.write(module.i_modulename);
        }
    }
    
    static function pyang_plugin_init() {
        Plugin.register_plugin(new HxPlugin());
    }
}