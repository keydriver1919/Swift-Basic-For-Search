//控制流程(Control Flow)
var array1 = [1,3,5]
var set1:Set = [11,33,55,77]
var dic1 = ["一":111,"三":333,"五":555,"七":777,"九":999]



//一. 循環語句
//1. for-in循環
//1.1 for-in循環集合
for index in array1{
    print(index)
}

//1.2 排序
for index in set1.sorted(){
    print(index)
}//雜湊排序

for (key,value) in dic1{
    print(key,value)
}
for key in dic1.keys{
    print(key)
}
for value in dic1.values{
    print(value)
}


//1.3列舉循環
for enum1 in array1.enumerated() {
    print(enum1)
}
for (index, value) in array1.enumerated() {
    print((index + 1,value))
}//元組


//1.4 不使用區間值 _
  let base = 2
  var total = 1
  for _ in 1...3{
    total *= base
  }//乘三次
  print(total)




//2. while循環
//2.1 循環直到
var a = 1
while a <= 5 {
    print("a:", a)
    a+=1
}
//2.2 寫法2:repeat-while
var b = 500
repeat{
  b *= 2
}while b<100//直到
print(b)



//3. 控制轉移語句
//3.1 控制轉移語句while
var number = 1
gameLoop: while number < 10 {//發生
    switch number {
    case 1...4:
        number += 1
    case 5:
        number *= 10
        break gameLoop
    default:
        number += 1
    }
    print(number)
}
    print(number)


//3.2 continue
for n in 1...10 {
    if n % 2 == 0 {
        // 停止本循環，進入下個
        continue
    }
    print(n)
}
//3.3 break
for n in 1...10 {
    if n > 2 {
        // 停止循環
        break
    }
    print(n)
}




//二.條件語句
//4. if-else語句
var array2 = [1,3,5]
var set2:Set = [11,33,55,77]
var dic2 = ["一":111,"三":333,"五":555,"七":777,"九":999]

//4.1.1 if-else:包含
if !array2.contains(2){
    print("T")
}else{
    print("F")
}

//4.1.2 if-else:雜湊值
var set3:Set = [33,11,55,77]
if set2.hashValue == set3.hashValue{
    print("T")
}else{
    print("F")
}

//4.1.3 if-else:optional、bool
var optional1:Int? = 404
optional1 = nil
var bool1 = true
//皆成立
if bool1/*為真*/ && optional1 == nil || optional1 != nil {
  print("bool1為真、且op1為空;或op1不為空，印出")
  optional1 = 1
  print("\(optional1!)")//!強制展開(確定有值才用)
}else{
  print("else印出")
}



//5. switch語句
/* switch(比對)
5.1元組匹配
5.2區間匹配
5.3值綁定
5.4雙條件where
5.5直接執行fallthrough
 */
var switchValue = (3333333333333333333,33)//元組匹配
switch switchValue {
    case (var x ,20...33) where switchValue == (3333333333333333333,33)://值綁定、區間匹配、雙條件where
        print("switch代入值\(x)")
        fallthrough//接著執行下個case、fallthrough不比對直接執行
    case (0,0):
        print("沒有比對，直接跑(fallthrough)")
    default://都沒有
        print("switch都沒有")
}



//6. guard else語句
    /*1. guard let else func(沒有的話就)
      2. _省略外部參數
      3.argument:外部參數(參數標籤)
      4.預設參數名
      5.無返回值:Void=()
    */
func post(_ array:[String], argument dic: [String: String] = ["default鍵名":"default值名"]) -> Void {
    guard let key = dic["key"] else {
        return
    }
    print("有鍵：\(key)")//不成立return結束
    
    guard let value = dic["value"] else {
        print("value沒值1")
        return
    }
    print("有值1：\(value)")
    
    guard let value2 = dic["value2"] else {
        print("value沒值2")
        return
    }
    print("有值2：\(value2)")
}
post(["array"], argument: ["key":"鍵名post1"])
post(["array"], argument: ["key":"鍵名post2","value":"值名1","value2":"值名2"])
