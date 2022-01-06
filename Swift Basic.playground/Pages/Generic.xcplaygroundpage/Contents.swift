//泛型(generic)


//1.函式能解決的問題
// 定義一個將兩個整數變數的值互換的函式
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
// 從函式外部叫入參數
var oneInt = 12
var anotherInt = 500
swapTwoInts(&oneInt, &anotherInt)
// 印出：互換後的 oneInt 為 500，anotherInt 為 12
print("互換後的 oneInt 為 \(oneInt)，anotherInt 為 \(anotherInt)")



// 與上面定義的函式功能相同 只是這時互換的變數型別為字串
func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}




//2.泛型函式 3. 型別參數
// 目前有Int和String可進
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// 首先是兩個整數
var oneInt2 = 12
var anotherInt2 = 320
swapTwoValues(&oneInt2, &anotherInt2)

// 再來是兩個字串
var oneString = "Hello"
var anotherString = "world"
swapTwoValues(&oneString, &anotherString)



//4.定義泛型型別
// 定義一個泛型結構 Stack 其佔位型別參數命名為 Element
struct Stack<Element> {
    // 將型別參數用於型別標註 設置一個型別為 [Element] 的空陣列
    var items = [Element]()
    
    // 型別參數用於方法的參數型別 方法功能是增加一個元素到陣列最後一員
    mutating func push(_ item: Element) {
        items.append(item)
    }
    // 型別參數用於方法的返回值型別 方法功能是移除陣列的最後一個元素
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

// 先宣告一個空的 Stack 這時才決定其內元素的型別為 String
var stackOfStrings = Stack<String>()

// 依序放入三個字串
stackOfStrings.push("one")
stackOfStrings.push("two")
stackOfStrings.push("three")

// 然後移除掉最後一個元素 即字串 "three"
stackOfStrings.pop()
// 現在這個 Stack 還有兩個元素 分別為 one 及 two



//4.1擴展泛型型別
//擴展一個名稱為topItem的唯讀計算屬性，它會返回這個堆疊的最後一個元素，且不會將其移除
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }//三元取值
}

if let topItem = stackOfStrings.topItem {
    // 印出：最後一個元素為 two
    print("最後一個元素為 \(topItem)")
}



//5.型別約束（泛型參數的遵從類別與協定）

//func 泛型函式名稱<T: 某個類別, U: 某個協定>(參數: T, 另一個參數: U) {
//    函式內部的程式
//}

//
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// 首先找看看 [Double] 陣列的值
let doubleIndex = findIndex(of: 9.2, in: [68.9, 55.66, 10.05])
// 因為 9.2 不在陣列中 所以返回 nil
// 接著找 [String] 陣列的值
let stringIndex = findIndex(of: "Kevin", in: ["Adam", "Kevin", "Jess"])
// Kevin 為陣列中第 2 個值 所以會返回 1



//6.關聯型別(佔位型別)
//協定被遵從後才會指派
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct NewStack<Element>: Container {
    // Stack<Element> 原實作的內容
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // 原本應該要寫 typealias
    // 但因為 Swift 會自動推斷型別 所以下面這行可以省略
    // typealias Item = Element
    
    // 協定 Container 實作的內容
    //(因自動推斷，可直上Element泛型型別)
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}



//6.1 經由擴展一個已存在的型別來設置關聯型別
extension Array: Container {}

protocol OtherContainer {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}



//7. 泛型where(雙條件)語句
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        
    // 檢查兩個容器含有相同數量的元素
    if someContainer.count != anotherContainer.count {
        return false
    }
    // 檢查每一對元素是否相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    // 所有條件都符合 返回 true
    return true
}



//7.1 泛型where實際使用函式

// 宣告一個型別為 NewStack 的變數 並依序放入三個字串
var newStackOfStrings = NewStack<String>()
newStackOfStrings.push("one")
newStackOfStrings.push("two")
newStackOfStrings.push("three")

// 宣告一個陣列 也放置了三個字串
var arrayOfStrings = ["one", "two", "three"]

// 雖然 NewStack 跟 Array 不是相同型別
// 但先前已將兩者都遵循了協定 Container
// 且都包含相同型別的值
// 所以可以把這兩個容器當做參數傳入函式
if allItemsMatch(newStackOfStrings, arrayOfStrings) {
    print("所有元素都符合")
} else {
    print("不符合")
}
// 印出：所有元素都符合

