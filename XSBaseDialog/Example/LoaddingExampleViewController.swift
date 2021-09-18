//
//  LoaddingExampleViewController.swift
//  XSBaseDialog
//
//  Created by ZB-YF-HXS on 2021/3/18.
//

import UIKit

class LoaddingExampleViewController: UIViewController {
    
    lazy private var btnSingle:UIButton = {
        self.btnSingle = self.createBtn(text: "单个Loadding", frame: CGRect.init(x: 12.0, y: 120.0, width: self.view.frame.width - 24.0, height: 50.0))
        self.btnSingle.addTarget(self, action: #selector(onBtnSingleClick(_:)), for: .touchUpInside)
        return self.btnSingle
    }()
    
    @IBAction private func onBtnSingleClick(_ sender:Any) {
        let hud = XSBaseLoaddingView.showHudToView(view: view, text: NSMutableAttributedString.init(string: "正在加载，请稍等一下，5秒后关闭"))
        debugPrint(hud)
        weak var weakSelf = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            // hud.close()
            XSBaseLoaddingView.closeAllHudInView(view: weakSelf?.view ?? UIView.init())
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Loadding"
        view.addSubview(btnSingle)
    }
    
    func createBtn(text:String,
                   frame:CGRect) -> UIButton {
        
        let btn = UIButton.init(frame: frame)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10.0
        btn.layer.borderWidth = 0.5
        let color = UIColor.init(red: 80.0/255.0, green: 12.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        btn.layer.borderColor = color.cgColor
        btn.setTitle(text, for: .normal)
        btn.setTitleColor(color, for: .normal)
        return btn
    }

    deinit {
        debugPrint("deinit LoaddingController")
    }
}
