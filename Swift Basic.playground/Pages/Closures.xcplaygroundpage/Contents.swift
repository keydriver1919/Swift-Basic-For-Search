//閉包(Closures)

//一. 閉包表達式
//一般寫法
func addTwoInts(number1: Int, number2: Int) -> Int {
    return number1 + number2}//要當parameter的func
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")}// 函式型別為 "(Int, Int) -> Int"
printMathResult(addTwoInts, 12, 85)

//閉包寫法
printMathResult({(number1: Int, number2: Int) -> Int in return number1 + number2}, 12, 85)

/*閉包簡寫1
  1.1 參數型別可推斷出來，因此可隱藏
  1.2 單行可隱藏return*/
printMathResult({number1, number2 in number1 + number2}, 12, 85)

//1.3 閉包簡寫2:參數名縮寫
printMathResult({$0 + $1}, 12, 85)

//1.4 閉包簡寫3:運算子閉包簡寫
printMathResult(+, 12, 85)

//1.5 閉包簡寫4:尾隨閉包簡寫(太長可寫外面，唯一參數>可省略()
//sortedName = names.sorted() { $0 > $1 }



//二. 捕獲值(巢狀函式抓外部值)
//整數參數、回傳"() -> Int"的閉包
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 3
//巢狀函式:func包含在func
    func incrementer() -> Int {
        runningTotal += amount//捕獲runningTotal、amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)//會呼叫+10巢狀函式
incrementByTen() // +10
incrementByTen() // +10
incrementByTen() // +10

// 若再宣告一改捕獲值常數
let incrementBySix = makeIncrementer(forIncrement: 777)
print(incrementBySix()) // +777

// 第一個常數仍然一樣
print(incrementByTen()) // +10


//閉包是參考型別(指派給一常數)
let alsoIncrementByTen = incrementByTen

// 仍是+10
print(alsoIncrementByTen()) //+10




//三. 逃逸閉包(@escaping允許逃逸)

// 參數為一個閉包的函式 參數型別前面標註 @escaping
var completionHandlers: [() -> Void] = []
func escapingClosure(completionHandler: @escaping () -> Void) {
      // 這個函式將閉包加入一個函式之外的陣列變數中
    completionHandlers.append(completionHandler)
}
// 定義另一個[參數不為逃逸的閉包]的函式
func noneEscapingClosure(closure: () -> Void) {
    closure()
}

// 定義一個類別
class SomeClass {
    var x = 10
    func doSomething() {
        // 使用前面兩個函式，都使用尾隨閉包
        // 傳入當參數的閉包 內部都是將實體的屬性指派為新的值
        
        // 參數型別標註為 @escaping 的閉包
        // 需要顯式地參考 self
        escapingClosure(){self.x = 100}

        // 而為非逃逸的閉包
        // 其內可以隱式地參考 self
        noneEscapingClosure { x = 200 }
    }
}

// 生成一個實體
let instance = SomeClass()

// 呼叫其內的方法
instance.doSomething()
// 接著那兩個前面定義的函式都會被呼叫到 所以最後實體的屬性 x 為 200
print(instance.x)

// 接著呼叫陣列中的第一個成員
// 也就是示範逃逸閉包的函式中 會將閉包加入陣列的這個動作
// 而這個第一個成員就是 { self.x = 100 }
completionHandlers.first?()
// 所以這時實體的屬性 x 便為 100
print(instance.x)




//四. 自動閉包（延遲，呼叫才會起執行）
// 首先宣告一個有五個成員的陣列
var customersInLine = ["Albee","Alex","Eddie","Zack","Kevin"]

// 印出：5
print(customersInLine.count)

// 接著宣告一個閉包 會移除掉陣列的第一個成員
let customerProvider = { customersInLine.remove(at: 0) }

// 這時仍然是印出：5
print(customersInLine.count)

// 直到這個閉包被呼叫時 才會執行
// 印出：開始移除 Albee ！
print("開始移除 \(customerProvider()) ！")

// 這時就只剩下 4 個成員了 印出：4
print(customersInLine.count)

// 這時 customersInLine 為 ["Alex", "Eddie", "Zack", "Kevin"]

// 定義一個[參數為閉包]的函式
func serve(customer customerProvider: () -> String) {
    // 函式內部會呼叫這個閉包
    print("開始移除 \(customerProvider()) ！")
}

// 呼叫函式時 [移除陣列第一個成員]這個動作被當做閉包的內容
// 閉包被當做參數傳入函式
// 這時才會移除陣列第一個成員
serve(customer: { customersInLine.remove(at: 0) } )
print(customersInLine.count)


// 這時 customersInLine 為 ["Eddie", "Zack", "Kevin"]

// 這個函式的參數型別前面標註了 @autoclosure
// 表示這參數可以是一個自動閉包的簡化寫法
func serve(customer customerProvider: @autoclosure () -> String) {
    print("開始移除 \(customerProvider()) ！")
}

// 因為函式的參數型別有標註 @autoclosure 這個參數可以不用大括號 {}
// 而僅僅只需要[移除第一個成員]這個表達式 而這個表達式會返回[被移除的成員的值]
serve(customer: customersInLine.remove(at: 0))
print(customersInLine.count)



//自動閉包允許逃逸
// 這時 customersInLine 為 ["Zack", "Kevin"]

// 宣告另一個變數 為一個陣列 其內成員的型別為 () -> String
var customerProviders: [() -> String] = []

// 定義一個函式 參數型別前面標註 @autoclosure @escaping
// 表示參數是一個可逃逸自動閉包
func collectCustomerProviders(
  _ customerProvider: @autoclosure @escaping () -> String) {
    // 函式內部的動作是將當做參數的這個閉包 再加入新的陣列中
    // 因為可逃逸 所以不會出錯
    customerProviders.append(customerProvider)
}

// 呼叫兩次函式
// 會將 customersInLine 剩餘的兩個成員都移除並轉加入新的陣列中
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

// 印出：獲得了 2 個成員
print("獲得了 \(customerProviders.count) 個成員")

// 最後將這兩個成員也從新陣列中移除
for customerProvider in customerProviders {
    print("開始移除 \(customerProvider()) ！")
    print(customersInLine.count)

}
// 依序印出：
// 開始移除 Zack ！
// 開始移除 Kevin ！
