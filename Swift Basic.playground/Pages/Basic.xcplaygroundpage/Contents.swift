//基礎知識(basic)

//1. 基本型別
//1.1 宣告
let constant1:UInt! = 0x65//16進數字101
var variable1:Double? = 0b110010100, string1 = "字符1"
//無符號整數、!隱式解析(先確定有值)、;同行、2進字404
typealias Typealias = Int64;let max1: Typealias = Typealias.max//自定義型別別名、取類型最大值
var count1 = variable1! / Double(constant1)//為求計算->轉型
print("宣告:", constant1, variable1, string1)//宣告
print("自定義、取類型最大值:", max1)//取類型最大值
print("為求計算>轉型:", count1)//取optional值、為求計算->轉型

//1.2 元組
let tuple1 = (tuple1: "變量字符1", tuple2: variable1, tuple3: constant1)
var (tupleString1, tupleVariable1, _) = tuple1//分解成三個變數、_取消第三個
print("字符數字相加轉型:", string1 + " = " + String(Int(count1))) //字符數字相加、轉2次
print("嵌入資料:", "\(string1) = \(count1)") //字串插數字
print("以名稱取:", tuple1.tuple2)//以名稱取
print("以索引取:", tuple1.0)//以索引取
print("以分解元件名取出:", "\(tupleVariable1)")//以分解元件名取



//2. 運算子

//2.1 數值運算子
var v = -9%4;print("取餘:", v)
v *= 4;print("四則:", -v)
//2.2 空值運算子(有值出1、沒值出2)
var option1:String?
var option2 = "沒值出2"
print("\(option1 ?? option2)")
//2.3 三元運算子a?b:c，a成立出b、nil出c，等同if else
var abc = 33
print((1, "2", 2) < (1, "234", 1) ? b+1000 : 10)//String是比編碼大小、只比第一個比對到的
//2.4 恆等運算子（在類別與結構）



//3. 字串及字元

//3.1 進位
let a = 10e-3 //(=10*10^-3)
let b = 0xAp-3//16進(=10*2^-3)
print("進位換算:", a, b)

/*進位:
整數進位前綴 2,8,16box;
2:0b,8:0o,16:0x;
Double:64位,15字;Float32位,6字;*/

//3.2 特殊符號
let special1 = """
"第一行"\0空字元\
刪到底\r(回車鍵，刪到底)，(\\\\=反斜線)，(\"\""=雙引號)，(\'\'=單引號)
\n(\\n＝換行)，\t(\\t＝tab鍵)
第二行\
(反斜線\\放行末=上拉一行)
特殊符號：\u{1F425}
"""
print(special1)

var special2 = #"""
特殊符號：\u{2665}

"""#
print(special2)

var special3 = """
1
2
3
"""
print(special2+special3)//換行追加

//3.3.1 前綴成立
if special1.hasPrefix("\"第一行\"") {
    print("hasPrefix.Success")
}

//3.3.2 後綴成立
if special1.hasSuffix("""
第二行\
(反斜線\\放行末=上拉一行)
特殊符號：\u{2665}
""") {
    print("hasSuffix.Success")
}

/*補充
特殊符號、跳脫字元：
行末\不自動換行、\0(空字元)、\\(反斜線)、\t(水平 tab)、\n(換行)、\r(回車鍵，刪到底)、\"(雙引號，"""內無需轉譯，"""需=\"\"\")、\'(單引號)。
特殊符號(愛心等等---)：\u{n}。Unicode純量，n為任意1到8位16進制數字
##：使特殊字符失效

未添入部分
\b    退格(BS) ，將當前位置移到前一列
\f    換頁(FF)，將當前位置移到下頁開頭
\v    垂直製表符
\000    1到3位八進位數所代表的任意字元
\xhh...    1到2位十六進位所代表的任意字元*/



//3.4 字串索引
var dog = "Dog!"
let index = dog.index(dog.startIndex, offsetBy: 2);print("索引2:", dog[index])//索引2
for index in dog.indices {//indices訪問每個字符索引
    print("訪問每個字符索引:\(dog[index]) ", terminator: "")}



//3.5 字元迴圈
for character in dog{
  print(character)}
print(dog[dog.startIndex])//字符頭
print(dog[dog.index(before: dog.endIndex)])//endIndex=最後一個字符後位置
print(dog[dog.index(after: dog.startIndex)])//startIndex=第一個字符位置
