//巢狀型別（Nested Types）

//1. 定義一巢狀型別
struct Poker {

    enum Suit: String {
        case Spades = "黑桃", Hearts = "紅心"
        case Diamonds = "方塊", Clubs = "梅花"
    }

    enum Rank: Int {
        case Two = 2, Three, Four, Five
        case Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
    }

    let rank: Rank, suit: Suit

    func description () {
        print("這張牌的花色是：\(suit.rawValue)")
        print("點數為：\(rank.rawValue)")
    }

}

let poker = Poker(rank: .King, suit: .Hearts)

// 印出：這張牌的花色是：紅心，點數為：13
poker.description()


//巢狀型別：在一個列舉、結構或類別中，還可以依照需求在其內，再定義列舉、結構或類別


//2. 外部使用巢狀型別
let diamondsName = Poker.Suit.Diamonds

// 印出：方塊
print(diamondsName.rawValue)
