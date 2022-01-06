//UIKit

//Appdelate：App生命週期
//Viewcontroller：單一AppUI畫面
//UIKit ：User Interface


//UIView：
//self.view：基底視圖

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. 定義一個 UIView 的常數 名稱為 firstView
        let firstView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        // 2. 使用addSubview方法，將 firstView 加入到 self.view（ViewController基底視圖）
        self.view.addSubview(firstView)

        /*UIScreen取得螢幕尺寸
        UIScreen.bounds.origin螢幕原點
        UIScreen.bounds.size螢幕尺寸
        */
        // 3. 取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size
        
        // 4. 設置 UIView 的位置到畫面的中心（中心點移到全螢幕的一半，center:元件的中心點）
        //使用CGPoint設置一個新的點
        firstView.center = CGPoint(
            x: fullScreenSize.width * 0.5 ,
            y: fullScreenSize.height * 0.5)

        // 5. 將 UIView 的底色設置為藍色
        firstView.backgroundColor = UIColor.blue

    }

}
