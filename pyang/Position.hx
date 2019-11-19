package pyang;

@:pythonImport("pyang.error", "Position") 
extern class Position {
    public var line : Int;
    public var ref : String;
}