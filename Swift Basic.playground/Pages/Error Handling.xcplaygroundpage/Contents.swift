//錯誤處理(Error Handling)
/*完整錯誤傳遞
do let try catch
簡單錯誤傳遞
if let try? else
無錯誤直接傳遞
let try!*/



//1. 設定販賣機器的錯誤種類（try：完整錯誤傳遞）

enum VendingMachineError: Error {//販賣機器
    case invalidSelection//無效選擇
    case outOfStock//缺貨
    case insufficientFunds(coinsNeeded: Int)//資金不足
}

//1.1 先定義一個結構來表示一個“販賣商品內容“（販賣商品內容：價錢/數量）
struct Item {
    var price: Int
    var count: Int
}
//1.2 再定義販賣機的販賣內容、投入錢幣統計、發出零食方法
class VendingMachine {
//1.2.1 販賣機的販賣內容
    var inventory = [//商品
        "可樂": Item(price: 25, count: 0),
        "洋芋片": Item(price: 20, count: 7),
        "巧克力": Item(price: 35, count: 11)
    ]
//1.2.2 已投入的錢幣
    var coinsDeposited = 0//目前已投入了多少錢幣
//1.2.3 發出零食方法
    func dispenseSnack(snack: String) {//出售（發出零食）
        print("買下 \(snack)")
    }
    
    
    

//2. 設定出售前的檢查（拋出檢查出的錯誤）
    //(throws)-->發生錯誤時拋出，未發生錯誤才執行

    func vend(itemNamed name: String) throws { //出售檢查
        
//2.1 檢查一，確認是否有這個商品，沒有的話會拋出“錯誤：無效選擇錯誤“
        guard var item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
//2.2 檢查二，檢查這個商品是否還有剩，已賣光拋出“錯誤：缺貨“
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
//2.3 檢查三，檢查目前投入的錢幣夠不夠，不夠的話拋出“錯誤：資金不足“
        guard item.price <= coinsDeposited else {
          //商品價格<=投入錢幣
//2.3.1 資金不足的參數：需補的錢幣
        throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
            //“資金不足“的參數為“需補多少錢幣“，所以是“商品價格 - 已投入的錢幣“
        }
        

// 2.4 所有檢查通過後，才確定會售出
        coinsDeposited -= item.price//目前投入 = 目前投入 - 商品價格
        item.count -= 1//商品數量 = 商品數量 - 1
        inventory[name] = item
        dispenseSnack(snack: name)
    }
}



//3. 執行：錯誤的捕獲、呼叫及處理
//(do：捕獲錯誤、try：呼叫拋出方法、catch：捕獲錯誤的處理)

// 生成一個自動販賣機類別的實體 並設置已投入 8 個錢幣
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 38

//3.1 捕獲拋出的錯誤
do {
//3.2 呼叫“拋出錯誤的方法“
    try vendingMachine.vend(itemNamed: "巧克力")
//3.2.1 可再寫上呼叫後時要做的事
    print("找錢\(vendingMachine.coinsDeposited)元")
// 3.3 每個 catch 為各自匹配的錯誤的處理
} catch VendingMachineError.invalidSelection {
    print("無此商品")
} catch VendingMachineError.outOfStock {
    print("商品已賣光")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("金額不足，還差 \(coinsNeeded) 個錢幣")
}




// 4. try，try?，try!

//4.1 完整錯誤傳遞(定義一個拋出函式，會返回一個 Int)
func someThrowingFunction() throws -> Int {
    // 內部執行的程式
    // 假設返回 10
    return 10
}

// 宣告一個可選型別 Int? 的常數 x
let x: Int?
do {
    // 呼叫拋出函式 會返回一個 Int
    x = try someThrowingFunction()
} catch {
    // 錯誤發生而被拋出 進而捕獲時 將其設為 nil
    x = nil
}

//4.2 轉換錯誤為可選值(try?：簡單錯誤傳遞)
let y = try? someThrowingFunction()

//4.3 禁用錯誤傳遞(try!：無錯誤直接傳遞)
let z = try! someThrowingFunction()

print(x,y,z)


//5. defer：必定執行區塊（不會因為發生錯誤拋出而中止）
func someMethod() throws {
    // 打開一個資源 像是開啟一個檔案
    
    defer {
        // 釋放資源記憶體或清理工作
        // 像是關閉一個開啟的檔案
    }
    // 錯誤處理 像是檔案不存在或沒有讀取權限
    // 及其他要執行的程式
}
//5.1 Hint：如果定義多個defer，會先執行最後一個定義的defer，再依序往前執行到第一個。
