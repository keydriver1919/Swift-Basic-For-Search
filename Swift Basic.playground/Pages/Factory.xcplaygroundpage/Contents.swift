

/*Factory
使用protocol，MVC架構
*/
protocol Protocol {
    func count()
    func playAll()
}


class Calculator: Protocol {
    func playAll() {
        count()
    }
    func count() {
    }
  }


class Add : Calculator {
    override func count() {
        print("執行方法")
    }
}


enum Calculators {
    case add
}
class CalculatorsFactory {
    func create(_ calculators: Calculators) -> Protocol {
        switch calculators {
            
        case .add:
            let add = Add()
            return add
        }
    }
}


//實際執行
//函式一
func createCalculator(_ calculators: Calculators) {
    let shapeFactory = CalculatorsFactory()
    shapeFactory.create(calculators).count()
    
}
//函式二
func getCalculator(_ calculators: Calculators) -> Protocol {
    let calculatorsFactory = CalculatorsFactory()
    return calculatorsFactory.create(calculators)
}


createCalculator(.add)

let add2 = getCalculator(.add)
add2.playAll()
