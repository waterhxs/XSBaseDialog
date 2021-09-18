//
//  XSBaseLoaddingView.swift
//  ProjectKit
//
//  Created by ZB-YF-HXS on 2021/3/15.
//

import UIKit

open class XSBaseLoaddingView: UIView {
    
    private let activityWidth:CGFloat = 45.0
    private let activityHeight:CGFloat = 45.0
    
    private var viewInsets:UIEdgeInsets = UIEdgeInsets.init(top: 20.0, left: 20.0, bottom: 64.0, right: 20.0)
    private var textInsets:UIEdgeInsets = UIEdgeInsets.init(top: 10.0, left: 15.0, bottom: 20.0, right: 15.0)
    private var activityInsets:UIEdgeInsets = UIEdgeInsets.init(top: 20.0, left: 15.0, bottom: 0.0, right: 15.0)
    private var message:NSMutableAttributedString = NSMutableAttributedString.init()
    
    lazy public var currSafeAreaInsets:UIEdgeInsets = {
        if #available(iOS 13.0, *) {
            let insets:UIEdgeInsets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
            return insets
        }
        else{
            return UIEdgeInsets.zero
        }
    }()

    lazy public var vBackgroud:UIView = {
        self.vBackgroud = UIView.init(frame: self.getViewDismissFrame())
        self.vBackgroud.clipsToBounds = true
        self.vBackgroud.layer.cornerRadius = 10.0
        self.vBackgroud.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9)
        self.vBackgroud.addSubview(self.vActivityIndicator)
        self.vBackgroud.addSubview(self.lbTitle)
        return self.vBackgroud
    }()
    
    lazy public var vActivityIndicator:UIActivityIndicatorView = {
        self.vActivityIndicator = UIActivityIndicatorView.init(frame: self.getActivityIndicatorDismissFrame())
        if #available(iOS 13.0, *) {
            self.vActivityIndicator.style = .large
        } else {
            // Fallback on earlier versions
        }
        self.vActivityIndicator.color = .white
        self.vActivityIndicator.startAnimating()
        return self.vActivityIndicator
    }()
    
    lazy public var lbTitle:UILabel = {
        self.lbTitle = UILabel.init(frame: self.getLabelDismissFrame())
        self.lbTitle.numberOfLines = 0
        self.lbTitle.textAlignment = .left
        self.lbTitle.textColor = .white
        return self.lbTitle
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(vBackgroud)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        adjustSubviews()
    }
    
    private func adjustSubviews() {
        if message.length > 0 {
            vBackgroud.frame = getViewFrame()
            lbTitle.frame = getLabelFrame()
            vActivityIndicator.frame = getActivityIndicatorFrame()
        }
        else{
            vBackgroud.frame = getViewDismissFrame()
            lbTitle.frame = getLabelDismissFrame()
            vActivityIndicator.frame = getActivityIndicatorDismissFrame()
        }
    }
}

extension XSBaseLoaddingView {
    
    func getAttrWidth(attr:NSMutableAttributedString,
                      height:CGFloat = 15.0) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.attributedText = attr
        label.sizeToFit()
        return label.frame.width
    }
    
    func getAttrHeight(attr:NSMutableAttributedString,
                       width:CGFloat = 10.0) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.attributedText = attr
        label.sizeToFit()
        return label.frame.height
    }
}

extension XSBaseLoaddingView {
    
    public func getViewDismissFrame() -> CGRect {
        let frame = getViewFrame()
        let result = CGRect.init(x: frame.minX + frame.width/2, y: frame.minY + frame.height/2, width: 0.0, height: 0.0)
        return result
    }
    
    func getViewFrame() -> CGRect {
        let screenWidth = self.frame.width
        let screenHeight = self.frame.height
        let maxWidth = screenWidth - viewInsets.left - viewInsets.right
        let maxHeight = screenHeight - currSafeAreaInsets.top - currSafeAreaInsets.bottom - viewInsets.top - viewInsets.bottom
        let maxTextWidth = maxWidth - textInsets.left - textInsets.right
        var textWidth = getAttrWidth(attr: message)
        var width = textInsets.left + textInsets.right
        var height = textInsets.bottom + textInsets.top
        if textWidth <= maxTextWidth {
            //textWidth = textWidth < activityWidth ? activityWidth : textWidth
            width = textWidth + textInsets.left + textInsets.right
            width = width < (activityWidth + activityInsets.left + activityInsets.right) ? (activityWidth + activityInsets.left + activityInsets.right) : width
            let textHeight = getAttrHeight(attr: message,
                                           width: textWidth)
            height = textHeight + textInsets.top + textInsets.bottom + activityHeight + activityInsets.top + activityInsets.bottom
        }
        else{
            textWidth = maxWidth - textInsets.left - textInsets.right
            width = maxWidth
            let textHeight = getAttrHeight(attr: message,
                                           width: textWidth)
            height = textHeight + textInsets.top + textInsets.bottom + activityHeight + activityInsets.top + activityInsets.bottom
        }
        
        height = height > maxHeight ? maxHeight : height

        let x = (screenWidth - width)/2
        let y = (screenHeight - height)/2
        return CGRect.init(x: x, y: y, width: width, height: height)
    }
}

extension XSBaseLoaddingView {
    
    func getLabelDismissFrame() -> CGRect {
        let frame = getViewFrame()
        let result = CGRect.init(x: frame.minX + frame.width/2, y: frame.minY + frame.height/2 + activityHeight + activityInsets.top + activityInsets.bottom + textInsets.top, width: 0.0, height: 0.0)
        return result
    }
    
    func getLabelFrame() -> CGRect {
        let viewFrame = self.getViewFrame()
        let screenWidth = self.frame.width
        let maxWidth = screenWidth - viewInsets.left - viewInsets.right
        var textWidth = getAttrWidth(attr: message)
        let maxTextWidth = maxWidth - textInsets.left - textInsets.right
        textWidth = textWidth > maxTextWidth ? maxTextWidth : textWidth
        let frame = CGRect.init(x: (viewFrame.width - textWidth)/2, y: activityInsets.top + activityInsets.bottom + textInsets.top + activityHeight, width: viewFrame.width - textInsets.left - textInsets.right, height: viewFrame.height - textInsets.top - textInsets.bottom - activityInsets.top - activityInsets.bottom - activityHeight)
        return frame
    }
}

extension XSBaseLoaddingView {
    
    func getActivityIndicatorDismissFrame() -> CGRect {
        let frame = getViewFrame()
        let result = CGRect.init(x: frame.width/2, y: frame.minY + activityInsets.top +  activityHeight/2, width: 0.0, height: 0.0)
        return result
    }
    
    func getActivityIndicatorFrame() -> CGRect {
        let viewFrame = self.getViewFrame()
        let frame = CGRect.init(x: (viewFrame.width - activityWidth)/2, y: activityInsets.top, width: activityWidth, height: activityHeight)
        return frame
    }
}

// MARK: For Call
extension XSBaseLoaddingView {
    
    public func show(text:NSMutableAttributedString){
        message = text
        lbTitle.attributedText = message
        adjustSubviews()
    }
    
    public func close() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.2) {
            weakSelf?.vBackgroud.alpha = 0.0
        } completion: { (complete) in
            weakSelf?.removeFromSuperview()
        }
    }
    
    /// 显示hud
    /// - Parameters:
    ///   - view: 覆盖的view
    ///   - text: 富媒体文本
    public static func showHudToView(view:UIView?,
                                     text:NSMutableAttributedString) -> XSBaseLoaddingView{
        guard view != nil else {
            return XSBaseLoaddingView.init(frame: .zero)
        }
        let hud = XSBaseLoaddingView.init(frame: view!.bounds)
        hud.show(text: text)
        view!.addSubview(hud)
        return hud
    }
    
    
    /// 关闭一个hud
    /// - Parameter hud: 需要关闭的hud
    public static func closeHud(hud:XSBaseLoaddingView?) {
        guard hud != nil else {
            return
        }
        UIView.animate(withDuration: 0.2) {
            hud!.vBackgroud.alpha = 0.0
        } completion: { (complete) in
            hud!.removeFromSuperview()
        }
    }
    
    /// 关闭一个view上所有的hud
    /// - Parameter view: 需要检测的view
    public static func closeAllHudInView(view:UIView?){
        guard view != nil else {
            return
        }
        var huds:[UIView] = []
        for subView in view!.subviews {
            if subView.isKind(of: XSBaseLoaddingView.self) {
                huds.append(subView)
            }
        }
        for subView in huds {
            if subView.isKind(of: XSBaseLoaddingView.self) {
                let hud:XSBaseLoaddingView = subView as! XSBaseLoaddingView
                UIView.animate(withDuration: 0.2) {
                    hud.vBackgroud.alpha = 0.0
                } completion: { (complete) in
                    subView.removeFromSuperview()
                }
            }
            else{
                subView.removeFromSuperview()
            }
        }
    }
}
