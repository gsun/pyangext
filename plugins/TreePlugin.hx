package;

import python.lib.io.TextIOBase;
import python.Dict;
import pyangext.Optparse.OptionParser;
import pyangext.*;
using Lambda;

/* need ot add module function pyang_plugin_init in generated python file, 
   and call TreePlugin.pyang_plugin_init() in pyang_plugin_init. */

class TreePlugin extends PyangPlugin {
    public function new() {
        super("yatree");
    }
    override public function add_opts(optparser:OptionParser) {}
    override public function add_output_format(fmts:Dict<String, PyangPlugin>) {
        multiple_modules = true;
        fmts.set("yatree", this);
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
            var chs = [for (ch in module.i_children) if (Statements.data_definition_keywords.has(ch.keyword)) ch];
            if (chs.length > 0) print_children(chs, module, fd, '', 'data');
            var mods = [module];
            for (i in module.search('include')) {
                var subm = ctx.get_module(i.arg);
                if (subm != null) mods.push(subm);
            }
            for (m in mods) {
                for (a in m.search('augment')) {
                    var augment : AugmentStatement = cast a;
                    var i_module = augment.i_target_node.i_module;
                    if (i_module != null && !modules.has(i_module) && !mods.has(i_module)) {
                        print_path("  augment", ":", augment.arg, fd);
                        var mode = switch (augment.i_target_node.keyword) {
                            case 'input': 'input';
                            case 'output': 'output';
                            case 'notification': 'notification';
                            default: 'augment';
                        }
                        print_children(augment.i_children, m, fd, '  ', mode);
                    }
                }
            }
            var rpcs = [for (ch in module.i_children) if (ch.keyword == 'rpc') ch];
            if (rpcs.length > 0) print_children(rpcs, module, fd, '  ', 'rpc');
            var notifs = [for (ch in module.i_children) if (ch.keyword == 'notification') ch];
            if (notifs.length > 0) print_children(notifs, module, fd, '  ', 'notification');
        }
    }
    
    function print_children(i_children:Array<Statement>, module:Statement, fd:TextIOBase, prefix:String, mode:String, width:Int=0) {
        var w = (width==0)?get_width(0, i_children, module):width;
        for (ch in i_children) {
            if ((ch.keyword == 'input' || ch.keyword == 'output') && (ch.i_children.length == 0)) continue;
            var last_i = i_children[i_children.length-1];
            var newprefix = (ch == last_i || (last_i.keyword == 'output' && last_i.i_children.length == 0))? (prefix + '   '):(prefix + '  |');
            print_node(ch, module, fd, newprefix, ch.keyword, w);
        }
    }
    function print_path(pre:String, post:String, path:String, fd:TextIOBase) {
        var line = pre + ' ' + path + post + '\n';
        fd.write(line);
    }
    function get_width(w:Int, chs:Array<Statement>, module:Statement) {
        var ww = w;
        for (ch in chs) {
            var nlen;
            if (['choice', 'case'].has(ch.keyword)) {
                nlen = 3 + get_width(0, ch.i_children, module);
            } else {
                if (ch.i_module.i_modulename == module.i_modulename) {
                    nlen = ch.arg.length;
                } else {
                    nlen = ch.i_module.i_prefix.length + 1 + ch.arg.length;
                }
            }
            if (nlen > ww) ww = nlen;
        }
        return ww;
    }
    function print_node(s:Statement, module:Statement, fd:TextIOBase, prefix:String, mode:String, width:Int=0) {
        var name = (s.i_module.i_modulename == module.i_modulename)?s.arg:(s.i_module.i_prefix + ':' + s.arg); 
        var line = " " + name;
        fd.write(line + '\n');
    }
    static function pyang_plugin_init() {
        Plugin.register_plugin(new TreePlugin());
    }
}