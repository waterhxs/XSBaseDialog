//
//  ToastExampleViewController.swift
//  ProjectKit
//
//  Created by ZB-YF-HXS on 2021/3/17.
//

import UIKit

class ToastExampleViewController: UIViewController {
    
    lazy private var btnLink:UIButton = {
        self.btnLink = self.createBtn(text: "带链接的Toast", frame: CGRect.init(x: 12.0, y: 120.0, width: self.view.frame.width - 24.0, height: 50.0))
        self.btnLink.addTarget(self, action: #selector(onBtnLinkClick(_:)), for: .touchUpInside)
        return self.btnLink
    }()
    
    @IBAction private func onBtnLinkClick(_ sender:Any) {
        showToast(attrMessage: getAttr())
    }
    
    lazy private var btnMore:UIButton = {
        self.btnMore = self.createBtn(text: "多内容的Toast", frame: CGRect.init(x: 12.0, y: self.btnLink.frame.maxY + 20, width: self.view.frame.width - 24.0, height: 50.0))
        self.btnMore.addTarget(self, action: #selector(onBtnMoreClick(_:)), for: .touchUpInside)
        return self.btnMore
    }()
    
    @IBAction private func onBtnMoreClick(_ sender:Any) {
        showToast(attrMessage: getAttr2())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Toast弹窗"
        view.backgroundColor = .white
        view.addSubview(btnLink)
        view.addSubview(btnMore)
        setupToast()
    }
    
    private func setupToast() {
        
        XSBaseToastManager.config(time: 3.0,
                                  defaultFont: UIFont.boldSystemFont(ofSize: 17.0),
                                  defaultTextColor: .red,
                                  actionURLSchemeWhiteList: ["http","https"]) { (u:URL) in
            
            let scheme = u.scheme ?? ""
            if scheme == "http" || scheme == "https" {
                DispatchQueue.main.async {
                    UIApplication.shared.open(u, options: [:]) { (complete) in
                        
                    }
                }
            }
        }
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
    
    func getAttr() -> NSMutableAttributedString {
        
        let attr:NSMutableAttributedString = NSMutableAttributedString.init()
        let attr1:NSMutableAttributedString = NSMutableAttributedString.init(string: "XSBase")
        attr1.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange.init(location: 0, length: attr1.length))
        attr1.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 30.0), range: NSRange.init(location: 0, length: attr1.length))
        attr.append(attr1)
        
        let attr2:NSMutableAttributedString = NSMutableAttributedString.init(string: "ToastView ")
        attr2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow, range: NSRange.init(location: 0, length: attr2.length))
        attr2.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 15.0), range: NSRange.init(location: 0, length: attr2.length))
        attr.append(attr2)
        
        let attr4:NSMutableAttributedString = NSMutableAttributedString.init(string: "\n")
        attr.append(attr4)
        
        let attr3:NSMutableAttributedString = NSMutableAttributedString.init(string: "百度一下?")
        attr3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow, range: NSRange.init(location: 0, length: attr3.length))
        attr3.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 20.0), range: NSRange.init(location: 0, length: attr3.length))
        attr3.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber.init(value: NSUnderlineStyle.single.rawValue), range: NSRange.init(location: 0, length: attr3.length))
        attr3.addAttribute(NSAttributedString.Key.link, value: "https://www.baidu.com", range: NSRange.init(location: 0, length: attr3.length))
        attr.append(attr3)
        
        let attr5:NSMutableAttributedString = NSMutableAttributedString.init(string: "\n")
        attr.append(attr5)
        
        let attr6:NSMutableAttributedString = NSMutableAttributedString.init(string: "去提问？")
        attr6.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow, range: NSRange.init(location: 0, length: attr6.length))
        attr6.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 20.0), range: NSRange.init(location: 0, length: attr6.length))
        attr6.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber.init(value: NSUnderlineStyle.single.rawValue), range: NSRange.init(location: 0, length: attr6.length))
        attr6.addAttribute(NSAttributedString.Key.link, value: "https://stackoverflow.com/", range: NSRange.init(location: 0, length: attr6.length))
        attr.append(attr6)
        
        let pStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        pStyle.lineSpacing = 4
        attr.addAttribute(NSAttributedString.Key.paragraphStyle, value: pStyle, range: NSRange.init(location: 0, length: attr.length))
        
        return attr
    }
    
    func getAttr2() -> NSMutableAttributedString {
        
        let attr:NSMutableAttributedString = NSMutableAttributedString.init()
        let attr1:NSMutableAttributedString = NSMutableAttributedString.init(string: "XSBase")
        attr1.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange.init(location: 0, length: attr1.length))
        attr1.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 30.0), range: NSRange.init(location: 0, length: attr1.length))
        attr.append(attr1)
        
        let attr2:NSMutableAttributedString = NSMutableAttributedString.init(string: "ToastView ")
        attr2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow, range: NSRange.init(location: 0, length: attr2.length))
        attr2.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 15.0), range: NSRange.init(location: 0, length: attr2.length))
        attr.append(attr2)
        
        let attr3:NSMutableAttributedString = NSMutableAttributedString.init(string: "More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More More ")
        attr3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow, range: NSRange.init(location: 0, length: attr3.length))
        attr3.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 20.0), range: NSRange.init(location: 0, length: attr3.length))
        attr.append(attr3)
        
        return attr
    }
}

extension ToastExampleViewController {
    
    func showToast(message: String) {
        XSBaseToastManager.showToast(message: message)
    }
    
    func showToast(attrMessage:NSMutableAttributedString) {
        XSBaseToastManager.showToast(messageAttr: attrMessage)
    }
    
    func closeAllLoaddingDialog() {
        XSBaseLoaddingView.closeAllHudInView(view: self.view)
    }
    
    func showSuccessDialog(message: String) {
        
    }
}
