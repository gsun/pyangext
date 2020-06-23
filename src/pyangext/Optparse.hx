package pyangext;

@:pythonImport("optparse", "Values") extern class Values { }
@:pythonImport("optparse", "Option") extern class Option { }

@:pythonImport("optparse", "OptionGroup") 
extern class OptGroup {
    public function add_options(option_list:Array<Option>):Void;
}

@:pythonImport("optparse", "OptParser") 
extern class OptParser {
    public function add_option_group(?args:String, ?kwargs:python.KwArgs<Dynamic>):OptGroup;
}

@:pythonImport("optparse") 
extern class Optparse {
    static public function make_option(?opts:String, ?attrs:python.KwArgs<Dynamic>):Option;
}