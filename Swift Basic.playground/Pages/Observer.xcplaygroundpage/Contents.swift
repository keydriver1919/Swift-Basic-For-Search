import UIKit


//觀察者接口
protocol PropertyObserver : class {
   
    func willChangePropertyName(propertyName:String, newPropertyValue:Int)
    func didChangePropertyName(propertyName:String, oldPropertyValue:Int)
}



//被觀察的人
class TestChambers {
    
    weak var observer:PropertyObserver?
    
    var testChamberNumber: Int = 0 {
        willSet(newValue) {
            observer?.willChangePropertyName(propertyName: "testChamberNumber", newPropertyValue:newValue)
        }
        didSet {
            observer?.didChangePropertyName(propertyName: "testChamberNumber", oldPropertyValue:oldValue)
        }
    }
}



//觀察者實體動作
class Observer : PropertyObserver {
    func willChangePropertyName(propertyName: String, newPropertyValue: Int) {
        print("\(propertyName)的值將要改變為\(newPropertyValue)")
    }
    
    func didChangePropertyName(propertyName: String, oldPropertyValue: Int) {
        print("\(propertyName)的值已經改變,原來的值為\(oldPropertyValue)")
    }
}



class ViewController: UIViewController{
 override func viewDidLoad() {
      super.viewDidLoad()
        
      var observerInstance = Observer()
      var testChambers = TestChambers()
      testChambers.observer = observerInstance
      testChambers.testChamberNumber = 123
        
   }
}
