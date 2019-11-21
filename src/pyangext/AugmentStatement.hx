package pyangext;

@:pythonImport("pyang.statements", "AugmentStatement") 
extern class AugmentStatement extends Statement {
    public var i_target_node : Statement;
}