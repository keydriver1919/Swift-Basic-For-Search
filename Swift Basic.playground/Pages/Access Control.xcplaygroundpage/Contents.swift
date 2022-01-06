//Access Control(存取控制)


//0. 原則
//0.1. internal是預設存取層級
//0.2. public或internal的類別，其內部成員都是internal



//1. 存取層級
//1.1 元組型別層級推斷
private var description = "Sunny day !"
internal var number = 300
public var name = "Joe Black"

// 這時這個元組的存取層級會根據成員裡最嚴格的 "private" 為基準
let someTuple = (description, number, name)



//1.2. 函式型別層級推斷
//函式的存取層級，是根據存取層級最嚴格的“參數“或“返回值“型別來決定
private class SomeClass {}

private func someFunction() -> SomeClass {
    return SomeClass()
}



//1.3. 列舉型別層級推斷
//列舉成員層級必須與列舉相同

// 定義列舉的存取層級為 public
public enum CompassPoint {
    // 則列舉成員都為 public
    case North
    case South
    case East
    case West
}

//1.4. 巢狀型別層級推斷

//1.4.1 以巢狀型別來說，定義在private型別中的巢狀型別，會自動指定為private。

//1.4.2 而在public或internal型別中，巢狀型別則自動指定為internal，這時如果要指定巢狀型別為public，則必須明確指定為public。



//2. 子類別層級規則

//繼承層級規則
//子類別可以覆寫父類別層級
//子類別成員可以存取限制更嚴格的父類別成員

// 定義一個 public 的類別 A
public class a {
    // 定義一個 private 的方法
    internal func someMethod() {}
}

// 繼承自 A 的類別 B 其存取層級為 internal
// 符合 子類別的存取層級限制不能比父類別更為寬鬆
internal class b: a {
    // 可以覆寫父類別的方法 更新為較寬鬆的存取層級
    // (當然必須符合自身的存取層級)
    override public func someMethod() {
        // 可以呼叫 存取層級限制更嚴格的父類別成員
        super.someMethod()
}
}



//3. 常數, 變數, 屬性及下標層級規則

// 定義一個 private 的類別
private class SomeClass2 {}

// 這時變數的型別為 private 則變數必須顯式的定義為 private
// 將 private 拿掉會報錯誤 因為會變成預設的 internal 則與規則不符
private var someInstance = SomeClass2()



//4. Getter、Setter層級規則

// 定義一個結構 預設存取層級為 internal
struct TrackedString {
    // 將變數的 Setter 存取層級指定為 private
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            // 所以在結構內部 是可以讀寫的
            numberOfEdits += 1
        }
    }
}

// 宣告一個結構的變數
var stringToEdit = TrackedString()

// 每修改一次 會經由屬性觀察器來將內部變數屬性加一
stringToEdit.value = "字串修改次數會被記錄"
stringToEdit.value += "每修改一次, numberOfEdits 數字會加一"
stringToEdit.value += "這行修改也會加一"

// 印出：已修改了 3 次
print("已修改了 \(stringToEdit.numberOfEdits) 次")



//4.1 也可以在必要時為Getter與Setter顯式指定存取層級，例子如下：
// 顯式指定這個結構的存取層級為 public
public struct TrackedString2 {
    // 結合 public 與 private(set)
    // 所以這時這個變數屬性的 Setter 為 private
    // Getter 為 public
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}


//5. 建構器層級規則
//例外：當建構器為必要建構器(required initializer)時，其存取層級必須與所屬型別相同。
//與函式或方法一樣，建構器參數的層級限制不能比建構器本身嚴格。
//像是一個internal的建構器，不能設置一個private的參數。


//5.1 預設建構器層級規則
//預設建構器的存取層級與所屬型別的存取層級相同。除非當型別的存取層級為public，
//則預設建構器會被設置為internal，如果需要一個public的建構器，必須自己定義一個，如下：
public class SomeClass3 {
    public init() {}
}



//6. 結構逐一建構器層級規則
//如果結構中任意儲存屬性的存取層級為private，那麼這個結構預設的成員逐一建構器的存取層級就是private，否則就為internal。
//如果需要在其他模組也可以使用這個結構的成員逐一建構器，則必須自行定義一個public的成員逐一建構器。


//7. 協定層級規則
//如果想為一個協定明確的指定存取層級，必須在定義此協定時指定。
//這樣可以確保這個協定只能在適當的存取層級範圍內被遵循。
//協定中的每個功能都與該協定的存取層級相同，這樣才能確保協定所有功能都可以被遵循此協定的型別存取。


//7.1 協定之繼承協定的層級規則
//從已存在的協定繼承了一個新的協定時，這個新協定的存取層級不能比已存在協定的寬鬆。
//例如，定義一個public的協定時，不能繼承自一個internal的協定。


//7.2 型別繼承協定的層級規則
//一個型別可以遵循一個存取層級限制更為嚴格的協定，例如，你可以定義一個public的型別，並遵循一個internal的協定。
//遵循了協定的型別的存取層級，會以型別本身與遵循的協定限制較嚴格的存取層級為準，
//如果一個public的型別，遵循了一個internal的協定，則在此型別作為符合協定的型別時，其存取層級也是internal。
//當你讓一個型別遵循某個協定並滿足其所有要求後，你必須確保所有這些實作協定的部分，
//其存取層級不能比協定更為嚴格。例如一個public的型別，遵循了internal的協定，
//則實作協定的部份最嚴格只能到internal存取層級。



//8. 擴展層級規則
//你可以在符合存取層級的情況下，擴展一個列舉、結構或類別，這個擴展會與擴展的對象擁有一樣的存取層級。
//例如，你擴展了一個public或internal型別，擴展中的成員則預設為internal，與原始型別中的成員一樣。
//而當擴展了一個private型別時，擴展成員則預設為private。
//或者，你也可以明確的指定擴展的存取層級，來讓其內成員都預設成一樣的存取層級。
//這個預設的存取層級仍可被個別成員所指定的存取層級覆蓋。

//8.1. 經由擴展遵從協定的層級規則
//如果你經由擴展來遵循協定，那你就不能顯式的指定這個擴展的存取層級了。
//而這個協定本身的存取層級會變成預設的存取層級，且擴展中每個協定功能的實作也是一樣的預設的存取層級。



//9. 泛型層級規則
//泛型型別或泛型函式的存取層級，由泛型型別或泛型函式，本身與泛型的型別約束參數中限制最嚴格的來確定。



//10. 型別別名層級規則
//自定義的任何型別別名都會被當做不同的型別來做存取控制。型別別名不能擁有比原始型別限制更為寬鬆的存取層級。
//* 一個public的型別，可以宣告private、internal或public的型別別名。
//* 一個private的型別，僅能宣告private的型別別名，不能宣告為internal或public的型別別名。

