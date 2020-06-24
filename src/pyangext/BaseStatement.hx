package pyangext;

@:pythonImport("pyang.statements", "BaseStatement") 
extern class BaseStatement extends Statement {
    public var i_identity : String;
}