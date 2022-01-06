//函數(Func)：有名稱的閉包



//一. 函式參數

//1.1 回調函式參數：函式當作參數傳送
func func1(number1: Int, number2: Int) -> Int {
    return number1 + number2
}
//func1傳入三參數func2
func func2(_ math: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("函式1傳入函式2=\(math(a, b))")
}
//func1傳入func2
func2(func1, 3, 5)


//1.2 可變數量參數(...、要放最後、只能一個)
func multiple(numbers: Int...) -> Int {
    return numbers.count
}
print("可變數量參數", multiple(numbers:1, 3, 5))


//1.3 輸入輸出參數
//(可以在外部修改參數的函式)
func newNumber(number: inout Int) {
    number *= 2
}
var n = 10
print(n) // 這時 n 為 10
// 傳入的參數+&在函式結束後 改變仍然存在
newNumber(number: &n)
print(n) // 所以這時再印出 就會是 20
//無預設值、不能是常數、字串、輸入加&
//屬性、下標有提到




//二. 函式返回值
//2.1 一般返回值
func f1(parameter: Int) -> Int {
    return parameter + 1
}
func f2(parameter: Int) -> Int {
    return parameter - 111
}
func chooseBool(bool: Bool) -> ((Int) -> Int) {
    return bool ? f1 : f2
}
//false、t=f1;f=f2、f3 = f1
let m = -2
let f3 = chooseBool(bool: m > 0)
print("函式返回", f3(10))



//2.2 optional函數返回值
func funNil(array: [Int]) -> (Int, Int)? {
    
    let n0 = array[0]+10
    let n1 = array[1]+100
    return (n0,n1)
}
//optional，確定回傳值有值再印
if let numbers = funNil(array: [11,22,33,44]) {
    print("確定回傳值有值再印:\(numbers.0) 跟 \(numbers.1)")
}else{
    print("nil")
}



//三. 巢狀函式
func chooseBool2(bool: Bool)->(Int)->Int{
    func f1(parameter: Int) -> Int {
        return parameter + 1
    }
    func f2(parameter: Int) -> Int {
        return parameter - 111
    }
    return bool ? f1 : f2
}

let n2 = -2
let f4 = chooseBool2(bool: n2 > 0)
print("嵌套函式", f4(10))



//四. 方法
//4.1 變異方法(struct):mutating修改方法外部的值
struct Point {
    var x = 14.0, y = 0.0
    // 為讓xy可在func內被修改，使用變異方法
    mutating func moveByX(_ deltaX: Double, y deltaY: Double) {
        self.x += deltaX
        y += deltaY
    }
}
var somePoint = Point(y: 1.0)
somePoint.moveByX(2.0, y: 3.0)
print("x: \(somePoint.x), y: \(somePoint.y)")

//4.2 修改類別
//變異方法傳送給self
// 將前面定義的結構 Point 改寫成這樣
struct AnotherPoint {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = AnotherPoint(x: x + deltaX, y: y + deltaY)
    }
}
var anotherPoint = Point(x:1111, y: 99.0)
anotherPoint.moveByX(123, y: 321)
print("x: \(anotherPoint.x), y: \(anotherPoint.y)")

//4.1.1
//enum、self的變異方法，修改外部值
enum TriStateSwitch {
    case off, low, high
    
    mutating func next() {
        switch self {
        case .off:
            self = .low
            print("1")
        case .low:
            self = .high
            print("2")
        case .high:
            self = .off
            print("3")
        }
    }
}
var ovenLight = TriStateSwitch.low

// 每次呼叫，會依序切換
ovenLight.next()
ovenLight.next()



// 五. 型別方法
//(static 屬於型別本身的方法)
class SomeClass {
    static func someTypeMethod() {//類別可將static替換成class，來允許子類別覆寫父類別方法
        print("型別方法")
    }
}
SomeClass.someTypeMethod()
