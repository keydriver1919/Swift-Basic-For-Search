//列舉(enums)


//1. 列舉表達式
//1.1 一般列舉

enum CompassPoint {
    case north
    case south
    case east
    case west
}//

//1.2 多個列舉
enum Planet {
    case Mercury,Venus,Earth,Mars,Jupiter,Saturn,Uranus,Neptune
}// 八大行星

//1.3 從列舉取值
var directionToHead = CompassPoint.west// 型別為 CompassPoint 的一個變數 值為其列舉內的 west

// 1.4 省略列舉型別名稱，列舉自動推斷
directionToHead = .north

//1.5 使用 Switch 語句匹配列舉值
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins") // 這行會被印出
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}



//2. 相關值表達式
//(定義型別，像元組)

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

// 指派 Barcode 型別 成員值為 upc
// 相關值為 (8, 85909, 51226, 3)
var productBarcode = Barcode.upc(8, 85909, 51226, 3)

// 如果要修改為儲存 QR Code 條碼
productBarcode = .qrCode("ABCDEFG")

// 這時 .upc(8, 85909, 51226, 3) 會被 .qrCode("ABCDEFG") 所取代
// 一個變數 同一時間只能儲存一個列舉的成員值(及其相關值)

switch productBarcode {
  //寫法1
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    //寫法2
case .qrCode(let productCode):
    print("QR Code: \(productCode).") // 會印出這行
}



//3. 初始值表達式
enum WeekDay: Int {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
}

//3.1 初始值隱式遞增
// 第一個成員有設置初始值 1, 接著下去成員的原始值就是 2, 3, 4 這樣遞增下去
enum SomePlanet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
let ourPlanet = SomePlanet.earth

//3.2 呼叫初始值
//使用初始值初始化列舉實體

// 印出：3
print(ourPlanet.rawValue)
//直接將該成員值設置為初始值
enum AnotherCompassPoint: String {
    case north, south, east, west
}

let directionPoint = AnotherCompassPoint.east

// 印出：east
print(directionPoint.rawValue)



//4. 遞迴列舉
//indirect
// 定義一個列舉
enum ArithmeticExpression {
    // 一個純數字成員
    case number(Int)

    // 兩個成員 表示為加法及乘法運算 各自有兩個[列舉的實體]相關值
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// 或是你也可以把 indirect 加在 enum 前面
// 表示整個列舉都是可以遞迴的
// indirect enum ArithmeticExpression {
//     case number(Int)
//     case addition(ArithmeticExpression, ArithmeticExpression)
//     case multiplication(ArithmeticExpression, ArithmeticExpression)
// }

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

// 計算 (5 + 4) * 2
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

// 印出：18
print(evaluate(product))
