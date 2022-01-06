//集合（Collection Types）

//1. 集合表達式
//1.1空集合
//全寫
var emptyArray1 = Array<Int>()
var emptyArray2:Array<Int> = []

var emptyDictionary1 = Dictionary<Int,String>()
var emptyDictionary2:Dictionary<Int,String> = [:]

var emptySet1 = Set<Character>()
var emptySet2:Set<Character> = []

//簡寫
var emptyArray3:[Int] = []
var emptyArray4 = [Int]()

var emptyDictionary3:[Int:String] = [:]
var emptyDictionary4 = [Int:String]()
//合集無簡寫



/*
集合：數組、字典、合集
數組[](有序同類、可重複)
字典[:](無序同類[鍵(不重複)、值])
合集[](無序同類(不重複))
*/



//1.2 數組、合集、字典
//1.3 區間
var array1 = [1,2,3,4,5,6,7,8,9]
var arrayR = Array(repeating: 0, count: 3)//初始值創建數組
var combine1 = array1 + arrayR//結合數組

var set1:Set = [11,33,55,77]
var dic1 = ["一":111,"三":333,"五":555,"七":777,"九":999]//(hash-map)

var range = ...5
var arrayRange = array1[range]

//單側區間
print(arrayRange.contains(7))//...5範圍內是否含7
print(array1[4...])
print(array1[...6])
print(array1[..<6])


//2. CRUD、(新增、刪除、讀取、修改)
//新增
array1.append(7)//數組末追加1
array1 += [9,9,9]//數組末追加
array1.insert(123456, at: 2)//插入
set1.insert(99)//合集追加
dic1["二"] = 222//字典追加


//修改
array1[0...2] = [2,4,6]
array1[0..<3] = [1,1,1,1,1]
dic1["一"] = 11111
dic1.updateValue(11111, forKey: "一")


//讀取
var getArray1 = array1[0]//取值

var key = dic1.keys//只取鍵
var value = dic1.values//只取值

var sort = value.sorted()//排序


//刪除
array1.remove(at:2)//指定刪除
array1.removeLast()//末尾刪除
array1.removeLast(2)//末尾刪除(數量)

set1.remove(77)

dic1["一"] = nil//刪除鍵跟值
dic1.removeValue(forKey: "二")//刪除鍵跟值

//全刪
set1.removeAll()
(dic1, array1) = ([:], [])



//3. 合集的集合(聯集、交集、差集、互斥)
let oddSet1: Set = [1, 3, 5, 7, 9]
let evenSet1: Set = [0, 2, 4, 6, 8]
let primeSet1: Set = [2, 3, 5, 7]
let set2: Set = [1, 3, 5]

print("聯集", oddSet1.union(evenSet1).sorted())//聯集
print("交集", oddSet1.intersection(evenSet1).sorted())//交集
print("差集", primeSet1.subtracting(oddSet1).sorted())//差集
print("互斥", oddSet1.symmetricDifference(primeSet1).sorted())//互斥

print(oddSet1.isSubset(of: primeSet1))//是否包含在
print(oddSet1.isSuperset(of: primeSet1))//是否包含
print(set2.isStrictSubset(of: oddSet1))//是否包含在,且不相等
print(oddSet1.isStrictSuperset(of: set2))//是否包含,且不相等
print(oddSet1.isDisjoint(with: evenSet1))//是否無交集

