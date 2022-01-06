
// 定義一個類別 Person
class Person {
    // residence 屬性為可選的 Residence 型別
    var residence: Residence?
}

// 定義一個類別 Residence
class Residence {
    // numberOfRooms 屬性為 Int 型別
    var numberOfRooms = 1
}

// 首先生成一個實體
let joe = Person()

// 這時 joe 實體內的可選屬性 residence 沒有設置值 所以會初始化為 nil
// 如果強制解析的話 會發生錯誤 如以下這行
//let roomCount = joe.residence!.numberOfRooms

// 所以這時可使用可選鏈來呼叫
if let roomCount = joe.residence?.numberOfRooms {
    print("Joe 有 \(roomCount) 間房間")
} else {
    print("無法取得房間數量")
}

// 上述 if 語句目前會印出：無法取得房間數量
// 接著為 joe.residence 設置一個 Residence 實體
joe.residence = Residence()

// 這時就會返回 1
// 記得這是返回一個可選型別 Int?
print(joe.residence?.numberOfRooms)
