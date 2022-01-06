//類別與結構（Structs & Classes）

/*
1. 比較
1.1 類別及結構的相同處：
屬性方法
下標
Init
擴展
協定

1.2 類別的額外功能：
繼承
Deinit
型別轉換
ARC
 
1.3 選擇使用結構的原則：
 (1) 資料少且較簡單
 (2) 需要的是資料拷貝
 (3) 不需要繼承
*/
 
class GameCharacter {
    var stats = CharacterStats()
    var attackSpeed = 1.0
    var name: String?
}
struct CharacterStats {
    var hp = 0.0
    var mp = 0.0
}




//2. 生成實體
let someGameCharacter = GameCharacter()
let someStats = CharacterStats()




//3. 取得屬性（點語法）
print("血量最大值為\(someGameCharacter.stats.hp)")

//3.1 指派屬性
someGameCharacter.stats.hp = 500
print(someGameCharacter.stats.hp)




//4.  結構逐一建構器（類別實體沒有這個功能）
let someoneStats = CharacterStats(hp: 120, mp: 100)
print(someoneStats.hp)




//5. "值型別"與"參考型別"
//類(參考(位置、操作實體);有繼承)，結構、列舉(值:操作複製)


//5.1 值型別：操作複製（兩者獨立，結構原資料不變）
// 這邊使用前面定義的 CharacterStats 結構
var oneStats = CharacterStats(hp: 120, mp: 100)
var anotherStats = oneStats

// 這時修改 anotherStats 的 hp 屬性
anotherStats.hp = 300
// 可以看出來已經改變了 印出：300.0
print(anotherStats.hp)

// 但 oneStats 的屬性不會改變
// 仍然是被生成實體時的初始值 印出：120.0
print(oneStats.hp)


//5.2 參考型別：操作實體（位置）
// 這邊使用前面定義的 GameCharacter 類別
let archer = GameCharacter()
archer.attackSpeed = 1.5
archer.name = "弓箭手"

// 指派給一個新的常數
let superArcher = archer
// 並修改這個新實體的屬性 attackSpeed
superArcher.attackSpeed = 1.8

// 可以看到這邊印出的都為：1.8
print("archer 的攻速為 \(archer.attackSpeed)")
print("superArcher 的攻速為 \(superArcher.attackSpeed)")




//6. 恆等運算子：等價於（是否參考同一實體）
/*
===等價於(參考是否相同)
!==不等價於
*/

if archer === superArcher {
    print("沒錯，是同一個類別實體")
}

