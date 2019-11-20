package;

import python.Dict;
import python.lib.io.IOBase;
import pyangext.Optparse.OptionParser;
import pyangext.*;

class TreePlugin extends PyangPlugin {
    public function new() {
        super("tree");
    }
    override public function add_opts(optparser:OptionParser) {}
    override public function add_output_format(fmts:Dict<String, PyangPlugin>) {
        multiple_modules = true;
        fmts.set("tree", this);
    }
    override public function emit(ctx:Context, modules:Array<Statement>, writef:IOBase) {
        var path:Array<String> = [];
        var tree_depth = (ctx.opts.tree_depth==null)?0:ctx.opts.tree_depth;
        var tree_line_length = (ctx.opts.tree_line_length==null)?0:ctx.opts.tree_line_length;
        emit_tree(ctx, modules, writef, tree_depth, tree_line_length, path);
    
    }
    override public function setup_ctx(ctx:Context) {}
    override public function setup_fmt(ctx:Context) {
        ctx.implicit_errors = false;
    }
    
    function emit_tree(ctx:Context, modules:Array<Statement>, writef:IOBase, depth:Int, lineLength:Int, path:Array<String>) {
    }
}