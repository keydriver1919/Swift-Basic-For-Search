//繼承


//1. 基礎類別（沒有繼承）
class GameCharacter {
    var attackSpeed = 1.52222
    var description: String {return "職業敘述"}//只有get
    func attack() {}
    }
let oneChar = GameCharacter()
print(oneChar.description)


//子類別
//2.1 生成子類別
class Archer: GameCharacter {
    var attackRange = 2.5 // 新增新屬性
}
let oneArcher = Archer()// 一併繼承
oneArcher.attackSpeed = 1.8//修改自己的繼承屬性


//2.2 繼承子類別
class Hunter: Archer {
    func fatalBlow() {print("施放必殺技攻擊！")}
}
let oneHunter = Hunter()
print("攻擊速度為 \(oneHunter.attackSpeed), 攻擊範圍為 \(oneHunter.attackRange)")//使用父類別方法
oneHunter.fatalBlow()




//3. 覆寫(重新定義父類別)

//3.1 覆寫實體方法
class OtherHunter: Archer {
    override func attack() {
        print("攻擊！這是獵人的攻擊！")
    }
}
let otherHunter = OtherHunter()
otherHunter.attack()

//3.2 覆寫屬性(若父為get&set，子需為get&set)
class AnotherHunter: Archer {
    // 覆寫父類別的屬性 重新實作 getter 跟 setter
    override var attackSpeed: Double {
        get {return 2.4}
        set {print(newValue)}
    }
}
let anotherHunter = AnotherHunter()
anotherHunter.attackSpeed = 123//set


//3.3 覆寫屬性觀察器
//父
class OtherArcher: GameCharacter {
    override var attackSpeed: Double {
        willSet {
            print("OtherArcher willSet")
        }
        didSet {
            print("OtherArcher didSet")
        }
    }
}
//子
class SomeHunter: OtherArcher {
    override var attackSpeed: Double {
        willSet {
            print("SomeHunter willSet")
        }
        didSet {
            print("SomeHunter didSet")
        }
    }
}
let someHunter = SomeHunter()
let otherArcher = OtherArcher()
// 設置新值會觸發willSet&didSet
someHunter.attackSpeed = 1.8//觸發父子
otherArcher.attackSpeed = 2222//只觸發父
//willSet先子後父，didSet先父後子


//4. 取用父類別
//存取父類別的屬性,方法及下標
class GoodHunter: Archer {
    override var description: String {
        return super.description + "加上:精通箭術的獵人"//super呼叫父類別
    }
}
let goodHunter = GoodHunter()
print(goodHunter.description)


/*5. 禁止覆寫&繼承：前面加上fanal
ex：final class func
*/


