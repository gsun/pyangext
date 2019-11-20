package pyangext;

@:pythonImport("pyang.plugin") 
extern class Plugin {
    static public function is_plugin_registered(name:PyangPlugin):Bool;
    static public function register_plugin(plugin:PyangPlugin);
}