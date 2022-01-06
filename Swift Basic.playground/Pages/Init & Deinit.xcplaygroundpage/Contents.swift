//Init & Deinit (建構與解構)



//1. 設置儲存屬性的初始值
//1.1 使用閉包或函式建立初始值
class SomeClass {
    let numbers: [Int] = {
        var temporaryNumbers = [Int]()
        var isBlack = false
        for i in 1...10 {
            temporaryNumbers.append(i)
        }
        return temporaryNumbers
    }()//()立即執行閉包回傳值
}

let someClass = SomeClass()
print(someClass.numbers)




//2. 為建構器提供參數
struct SimpleMath {
    var number: Double
    init(huge n: Double) {
        number = n * 100
    }
    init(tiny n: Double) {
        number = n / 10
    }
}

let oneSimpleMath = SimpleMath(huge: 30.0)
// 印出 3000.0
print(oneSimpleMath.number)

let anotherSimpleMath = SimpleMath(tiny: 10.0)
// 印出 1.0
print(anotherSimpleMath.number)



//3. 結構逐一建構器
struct CharacterStats {
    var hp = 0.0
    var mp = 0.0
}
let someoneStats = CharacterStats(hp: 120, mp: 100)//struct有自動生成建構器
print(someoneStats.hp)




//4.值型別(結構及列舉)的建構器委任
//建構器委任 - 委任自己self.init、建構器參數
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

//延伸畫座標
//self.只能struct內用
struct Rect {
    // 使用上面兩個定義的結構來儲存這個方形的原點及尺寸
    var origin = Point()
    var size = Size()
    
    // 三個建構器
    init() {}//多個建構器，為辨別外部參數不可省略
    init(origin: Point, size: Size) {//建構器提供參數
        self.origin = origin//self為struct內的vat origin
        self.size = size
    }
    init(center: Point, size: Size) {//算出中心點座標
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)//呼叫其他建構器算出中心
    }
}

//建構器1
let basicRect = Rect()//沒有設置任何屬性
//建構器2
let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0))
//建構器3
//先利用中心點與尺寸的長寬來算出原點的位置，再委任另一個建構器
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
print(basicRect.origin)
print(originRect.size)
print(centerRect.origin)




//5. 參考型別的建構器委任（類別的繼承與建構過程）


/*
5.1 類別建構器規則
 
5.1.1 類別建構器的委任關係
便利建構器(沒參數建構器)：建構必須委任類別中其他便利、指定建構器，最後一個必須委任指定建構器(平行)
指定建構器：必須委任父類別的指定建構器(向上)

 
5.1.2 建構器的繼承與覆寫
覆寫：指定建構器要+override、便利建構器直接重定義
 
5.1.3 建構器的自動繼承
子類別"沒有定義任何"指定建構器、自動繼承父類別指定建構器，否則不自動繼承
子類實作父類"所有"指定建構器，則會自動繼承父所有便利建構器
*/
 

//5.2 指定建構器、便利建構器與、建構器的自動繼承
//5.2.1 指定建構器、便利建構器
class GameCharacter {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[未命名]")//呼叫其他建構器
    }
}


// 使用指定建構器 生成實體後的屬性 name 為: Kevin
let oneChar = GameCharacter(name:"Kevin")
print(oneChar.name)

// 使用便利建構器 生成實體後的屬性 name 為: [未命名]
let anotherChar = GameCharacter()
print(anotherChar.name)



class Archer: GameCharacter {
    var attackRange: Double
    init(name: String, attackRange: Double) {
        self.attackRange = attackRange
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, attackRange: 1)
    }
}

// 繼承自父類別的建構器
let oneArcher = Archer()
// 覆寫自父類別並重新定義的建構器
let secondArcher = Archer(name: "Joe")
// 類別本身自己定義的建構器
let anotherArcher = Archer(name: "Adam", attackRange: 2.4)
print(anotherArcher.attackRange)



//5.2.3 建構器的自動繼承
class Hunter: Archer {//因沒自訂建構器而繼承所有父建構器
    var hp = 100
    var description: String {
        return "\(name) ,基礎血量為 \(hp)"
    }
}
let oneHunter = Hunter()
let secondHunter = Hunter(name: "Black")
let anotherHunter = Hunter(name: "Dwight", attackRange: 3)
print(anotherHunter.attackRange)





//6. 可失敗建構器init?
struct Animal {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }//return nil表建構失敗
        self.name = name
    }
}

// 傳入 Lion 當參數
var oneAnimal = Animal(name: "Lion")
if let one = oneAnimal {
    print("動物的名字為 \(one.name)")
}

// 傳入一個空字串當參數 (請注意 空字串與 nil 完全不一樣)
var anotherAnimal = Animal(name: "")
if anotherAnimal == nil {
    print("沒有傳入名字 所以建構過程中失敗了")
}





//7. 覆寫一個可失敗建構器

//不能將一個父類別的非可失敗建構器，覆寫成為可失敗建構器。

//定義一個類別 Document
class Document {
    // 可選型別的屬性
    var name: String?
    init() {}    // 使用這個建構器 會生成一個屬性 name 為 nil 的實體
    // 使用這個建構器 會生成一個屬性 name 不為空字串的實體
    // 或是建構失敗 返回 nil
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

// 定義一個繼承自 Document 的類別 AutomaticallyNamedDocument
class AutomaticallyNamedDocument: Document {
    // 覆寫父類別的建構器 會指派值給屬性
    override init() {
        super.init()
        self.name = "[未命名]"
    }
    // 覆寫父類別的可失敗建構器 成為 非可失敗建構器
    // 可以看到他將條件修改成為 不會有失敗的狀況發生
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[未命名]"
        } else {
            self.name = name
        }
    }
}


// 定義一個繼承自 Document 的類別 UntitledDocument
class UntitledDocument: Document {
    // 覆寫一個父類別的可失敗建構器 並向上委任到這個建構器
    override init() {
        // 這時必須強制解析這個父類別的建構器
        // 表示不會有失敗的狀況
        super.init(name: "[未命名]")!
    }
}




//8. 必要建構器
//required必要建構器
//所有繼承這個類別的子類別，都必須實作這個建構器：
class SomeClass4 {
    required init() {
        // 建構器執行程式的實作
    }


class SomeSubclass: SomeClass4 {
    required init() {
        // 必要建構器執行程式的實作
    }
}
//解構器
//物件死亡時會執行 deinit 方法裡的動作。
deinit {
//執行的解構過程
}
}
