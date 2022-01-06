/*

屬性為特定型別(類別、結構或列舉)的值，有以下幾種使用方式：

儲存屬性：在實體內儲存常數或變數，可以用於類別及結構。
計算屬性：在實體內計算一個值，可以用於類別、結構及列舉。
型別屬性：與前兩個不同，這是屬於型別本身的屬性。
屬性觀察器：用來觀察屬性值的變化，並以此觸發一個自定義的操作。


*/



//儲存屬性

//1. 儲存屬性(用於struct、class)
//定義一結構並儲存一"延遲變數"及"常數屬性"
struct Stored {
//1.1 延遲屬性（第一次使用屬性，才會創建初始化）
    lazy var lazyValueMax: Double = 300
    var ValueMax: Double
}
print("Stored1", stroed.lazyValueMax, stroed.ValueMax)//get


//宣告一"延遲變數"，傳入結構建構器並設置屬性值
var stroed = Stored(lazyValueMax: 500, ValueMax: 120)
stroed.ValueMax = 200
print("Stored2", stroed.lazyValueMax,stroed.ValueMax)//get




//2. 計算屬性（get執行,set更新）
class Computed {
    var hpValue: Double = 100
    var defenceValue: Double = 300
    var totalDefence: Double {
        get {//只有get時，可省略get{}
            return (defenceValue + 0.1 * hpValue)
        }
        set(levelUp) {
            hpValue = hpValue * (1 + levelUp)
            defenceValue = defenceValue * (1 + levelUp)
        /*newValue可省略set參數
        set {
            hpValue = hpValue * (1 + newValue)
            defenceValue = defenceValue * (1 + newValue)
        }*/
        }
    }
}
let computed = Computed()
print("Computed1", computed.totalDefence)//get
computed.totalDefence = 0.05//set參數
print("Computed2", "血量：\(computed.hpValue), 防禦力：\(computed.defenceValue)")



//3. 屬性觀察者observer(屬性值變化,自動觸發自訂操作)
class Observer {
    var hpValue: Double = 100 {
        willSet (hpChange) {
            // 新值傳入之前呼叫，新值作參數傳入、或newValue
            print("Observer1新的血量為\(hpChange)")
        }
        didSet {
            // 新值傳入時就叫，舊值作參數傳入、或oldValue
            if oldValue > hpValue {
                print("Observer2損血了！阿！")
            } else {
                print("Observer3補血了！耶！")
            }
        }
    }
}
let observer = Observer()
observer.hpValue = 90
//inout方式傳入函式，會被觸發



//4. 型別屬性type property (static=型別本身屬性，struct、enum、class可用)
class Type {
    static var storedTypeProperty = "Some value in class."//儲存型的型別屬性，內建lazy
    static var computedTypeProperty: Int {return 27}
    class var overrideableComputedTypeProperty: Int {return 107}//class=開放子類別覆寫
}
print("Type1",Type.storedTypeProperty)
Type.storedTypeProperty = "Another value."
print("Type2",Type.storedTypeProperty)//修改
print("Type3",Type.computedTypeProperty)
print("Type4",Type.overrideableComputedTypeProperty)
