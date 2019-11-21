package pyangext;

@:pythonImport("pyang.statements", "ModSubmodStatement") 
extern class ModSubmodStatement extends Statement {
    public var i_prefix : String;
}