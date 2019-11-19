package pyang;

@:pythonImport("optparse", "Values") extern class Values { }
@:pythonImport("optparse", "Option") extern class Option { }

@:pythonImport("optparse", "OptionGroup") 
extern class OptionGroup {
    public function add_options(option_list:Array<Option>);
}

@:pythonImport("optparse", "OptionParser") 
extern class OptionParser {
    public function add_option_group(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):OptionGroup;
}

@:pythonImport("optparse") extern class Optparse {
    static public function make_option(?opts:python.VarArgs<Dynamic>, ?attrs:python.KwArgs<Dynamic>):Option;
}