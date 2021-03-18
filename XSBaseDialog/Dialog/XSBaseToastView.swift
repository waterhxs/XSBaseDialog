//
//  XSBaseToastAlertController.swift
//  ProjectKit
//
//  Created by ZB-YF-HXS on 2021/3/12.
//

import UIKit

open class XSBaseToastView: XSBaseToastBaseViewController<XSBaseToastContentView> {
    
    private var message:NSMutableAttributedString = NSMutableAttributedString.init()
    private var viewInsets:UIEdgeInsets = UIEdgeInsets.init(top: 20.0, left: 20.0, bottom: 64.0, right: 20.0)
    private var textInsets:UIEdgeInsets = UIEdgeInsets.init(top: 10.0, left: 15.0, bottom: 10.0, right: 15.0)
    private var currDisplayTimeSec:Int = 0
    private var toastURLWhiteSchemes:[String] = []
    fileprivate var URLHandle:(_ u:URL)->() = {_ in}
    
    lazy public var currSafeAreaInsets:UIEdgeInsets = {
        if #available(iOS 13.0, *) {
            let insets:UIEdgeInsets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
            return insets
        }
        else{
            return UIEdgeInsets.zero
        }
    }()
    
    lazy private var mainWindow:UIWindow = {
        self.mainWindow = XSBaseToastUtil.windowWithLevel(level: UIWindow.Level.normal)
        return self.mainWindow
    }()
    
    lazy public var alertWindow:XSBaseToastWindow = {
        self.alertWindow = XSBaseToastWindow.createWindow(level: .toast, controller: self)
        return self.alertWindow
    }()
    
    lazy private var tvTitle:UITextView = {
        let frame = self.getLabelDismissFrame()
        self.tvTitle = UITextView.init(frame: frame)
        self.tvTitle.textColor = .white
        self.tvTitle.attributedText = self.message
        self.tvTitle.backgroundColor = .clear
        self.tvTitle.textContainerInset = .zero
        self.tvTitle.textContainer.lineFragmentPadding = 0
        self.tvTitle.isScrollEnabled = false
        self.tvTitle.textContainer.maximumNumberOfLines = 0
        self.tvTitle.delegate = self
        self.tvTitle.isEditable = false
        return self.tvTitle
    }()
    
    lazy public var mView:XSBaseToastContainerView = {
        let frame = self.getViewDismissFrame()
        self.mView = XSBaseToastContainerView.init(frame: frame)
        self.mView.clipsToBounds = true
        self.mView.layer.cornerRadius = 15.0
        self.mView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        self.mView.addSubview(self.tvTitle)
        return self.mView
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.addSubview(mView)
        self.view.backgroundColor = .clear
    }
}

extension XSBaseToastView: XSBaseToastProtocol {
    
    func handleURL(callback: @escaping (URL) -> ()) {
        URLHandle = callback
    }
    
    /// 主体的View
    var contentView: XSBaseToastContainerView {
        get {
            return mView
        }
        set {
            mView = newValue
        }
    }
    
    /// 显示的富媒体文本
    var currMessage: NSMutableAttributedString {
        get {
            return message
        }
        set{
            message = newValue
        }
    }
    
    /// 显示的秒数
    var displayTimeSecond: Int {
        get {
            return currDisplayTimeSec
        }
        set{
            currDisplayTimeSec = newValue
        }
    }
    
    /// 点击需要反馈的白名单
    var currURLSchmemWhiteList: [String] {
        get {
            return toastURLWhiteSchemes
        }
        set {
            toastURLWhiteSchemes = newValue
        }
    }
    
    /// 显示
    /// - Parameter message: 富媒体文本
    func show(message: NSMutableAttributedString) {
        
        self.message = message
        tvTitle.attributedText = message
        weak var weakSelf = self
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: .allowAnimatedContent) {
            weakSelf?.mView.frame = weakSelf!.getViewFrame()
        } completion: { (com) in}

        UIView.animate(withDuration: 0.1) {
            weakSelf?.tvTitle.frame = weakSelf!.getLabelFrame()
        } completion: { (com) in}
        
        self.alertWindow.makeKeyAndVisible()
    }
    
    /// 关闭
    func close() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: .allowAnimatedContent) {
            weakSelf?.mView.frame = weakSelf!.getViewDismissFrame()
        } completion: { (com) in}
        
        UIView.animate(withDuration: 0.1) {
            weakSelf?.tvTitle.frame = weakSelf!.getLabelDismissFrame()
        } completion: { (com) in}

        self.alertWindow.isHidden = true
        self.alertWindow.removeFromSuperview()
        self.alertWindow.rootViewController = nil
        self.alertWindow = XSBaseToastWindow.init()
        self.mainWindow.makeKeyAndVisible()
    }
    
    /// 设置背景颜色
    /// - Parameter color: 背景颜色
    func setBackgroudColor(color:UIColor){
        mView.backgroundColor = color
    }
}

extension XSBaseToastView: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let scheme = URL.scheme ?? ""
        // 如果白名单包含这个域名
        if toastURLWhiteSchemes.contains(scheme) {
            // 发送通知给需要调用的地方
            URLHandle(URL)
            return false
        }
        
        return true
    }
}

extension XSBaseToastView {
    
    func getViewDismissFrame() -> CGRect {
        let frame = getViewFrame()
        let result = CGRect.init(x: frame.minX + frame.width/2, y: frame.minY + frame.height/2, width: 0.0, height: 0.0)
        return result
    }
    
    func getLabelDismissFrame() -> CGRect {
        let frame = getViewFrame()
        let result = CGRect.init(x: frame.minX + frame.width/2, y: frame.minY + frame.height/2, width: 0.0, height: 0.0)
        return result
    }
    
    func getLabelFrame() -> CGRect {
        let viewFrame = self.getViewFrame()
        let frame = CGRect.init(x: textInsets.left, y: textInsets.top, width: viewFrame.width - textInsets.left - textInsets.right, height: viewFrame.height - textInsets.top - textInsets.bottom)
        return frame
    }
    
    func getViewFrame() -> CGRect {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let maxWidth = screenWidth - viewInsets.left - viewInsets.right
        let maxHeight = screenHeight - currSafeAreaInsets.top - currSafeAreaInsets.bottom - viewInsets.top - viewInsets.bottom
        let maxTextWidth = maxWidth - textInsets.left - textInsets.right
        var textWidth = getAttrWidth(attr: message)
        var width = textInsets.left + textInsets.right
        var height = textInsets.bottom + textInsets.top
        if textWidth <= maxTextWidth {
            width = textWidth + textInsets.left + textInsets.right
            let textHeight = getAttrHeight(attr: message,
                                           width: textWidth)
            height = textHeight + textInsets.top + textInsets.bottom
        }
        else{
            textWidth = maxWidth - textInsets.left - textInsets.right
            width = maxWidth
            let textHeight = getAttrHeight(attr: message,
                                           width: textWidth)
            height = textHeight + textInsets.top + textInsets.bottom
        }
        
        height = height > maxHeight ? maxHeight : height

        let x = (screenWidth - width)/2
        let y = screenHeight - currSafeAreaInsets.bottom - viewInsets.bottom - height
        return CGRect.init(x: x, y: y, width: width, height: height)
    }
    
    func getAttrWidth(attr:NSMutableAttributedString,
                      height:CGFloat = 15.0) -> CGFloat {
        return getAttrTextViewWidth(attr: attr,
                                    height: height)
    }
    
    func getAttrHeight(attr:NSMutableAttributedString,
                       width:CGFloat = 10.0) -> CGFloat {
        return getAttrTextViewHeight(attr: attr,
                                     width: width)
    }
    
    func getAttrTextViewWidth(attr:NSMutableAttributedString,
                              height:CGFloat = 15.0) -> CGFloat {
        let tv:UITextView = UITextView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: CGFloat.greatestFiniteMagnitude, height: height))
        tv.attributedText = attr
        tv.textContainerInset = .zero
        tv.textContainer.lineFragmentPadding = 0
        tv.isScrollEnabled = false
        let size = tv.sizeThatFits(CGSize.init(width: CGFloat(MAXFLOAT), height: height))
        return size.width
    }
    
    func getAttrTextViewHeight(attr:NSMutableAttributedString,
                               width:CGFloat = 10.0) -> CGFloat {
        let tv:UITextView = UITextView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: width, height: CGFloat.greatestFiniteMagnitude))
        tv.attributedText = attr
        tv.textContainerInset = .zero
        tv.textContainer.lineFragmentPadding = 0
        tv.isScrollEnabled = false
        let size = tv.sizeThatFits(CGSize.init(width: width, height: CGFloat(MAXFLOAT)))
        return size.height
    }
}
