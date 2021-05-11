//
//  XSBaseToastManager.swift
//  ProjectKit
//
//  Created by huangxuesong on 2021/3/13.
//

import UIKit

open class XSBaseToastManager: NSObject {
    
    public var onActionCallback:(_ u:URL)->() = {_ in}
    
    private var tasks:XSBaseToastTaskQueue = XSBaseToastTaskQueue<XSBaseToastProtocol>.init()
    private var timer:Timer?
    private var timeInterval:TimeInterval = 0.5
    private var displaySecond:Float = 5
    fileprivate var defaultFont:UIFont = UIFont.systemFont(ofSize: 16.0)
    fileprivate var defaultTextColor:UIColor = .white
    fileprivate var defaultBackgroudColor:UIColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
    fileprivate var schemeWhiteList:[String] = []
    private var maxCount: Float {
        return displaySecond/Float(timeInterval)
    }

    static let sharedInstance: XSBaseToastManager = {
        let instance = XSBaseToastManager.init()
        return instance
    }()
    
    override init() {
        super.init()
        setup()
    }
    
    fileprivate func setup() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(detectMessages(_:)), userInfo: nil, repeats: true)
    }
    
    @IBAction fileprivate func detectMessages(_ sender:Any) {
        
        if tasks.count > 0 {
            // get front on the queue
            var task = tasks.front
            task?.handleURL(callback: onActionCallback)
            task?.setBackgroudColor(color: defaultBackgroudColor)
            let displayTimeSecond = task!.displayTimeSecond
            
            if displayTimeSecond == 0 {
                task!.show(message: task!.currMessage)
                task!.displayTimeSecond += 1
            }
            else if displayTimeSecond >= Int(maxCount) {
                //task!.close()
                tasks.deQueue()?.close()
            }
            else{
                task!.displayTimeSecond += 1
            }
        }
        else{
            timer?.fireDate = Date.distantFuture
        }
    }
    
    fileprivate func show(message:NSMutableAttributedString){
        let toast = XSBaseToastView.init()
        toast.currMessage = message
        toast.currURLSchmemWhiteList = schemeWhiteList
        tasks.enQueue(toast)
        timer?.fireDate = Date.distantPast
    }
    
    fileprivate func show(text:String){
        let messageAttr:NSMutableAttributedString = NSMutableAttributedString.init(string: text)
        messageAttr.addAttribute(NSAttributedString.Key.font, value: defaultFont, range: NSRange.init(location: 0, length: messageAttr.length))
        messageAttr.addAttribute(NSAttributedString.Key.foregroundColor, value: defaultTextColor, range: NSRange.init(location: 0, length: messageAttr.length))
        let toast = XSBaseToastView.init()
        toast.currMessage = messageAttr
        toast.currURLSchmemWhiteList = schemeWhiteList
        tasks.enQueue(toast)
        timer?.fireDate = Date.distantPast
    }
}

extension XSBaseToastManager {
    
    /// 显示简单文本
    /// - Parameter message: 文本内容
    static func showToast(message:String) {
        XSBaseToastManager.sharedInstance.show(text: message)
    }
    
    /// 显示富文本内容
    /// - Parameter messageAttr: 富文本
    static func showToast(messageAttr:NSMutableAttributedString) {
        XSBaseToastManager.sharedInstance.show(message: messageAttr)
    }
}


// MARK: 设置一些属性
extension XSBaseToastManager {
    
    /// 配置弹窗参数
    /// - Parameters:
    ///   - time: 显示的时间
    ///   - defaultFont: 字体默认字号
    ///   - defaultTextColor: 字体默认颜色
    ///   - actionURLSchemeWhiteList: 需要处理事件的协议白名单
    ///   - actionCallback: 接收到协议点击的回调
    public static func config(time:Float = 4.0,
                              defaultFont:UIFont = UIFont.systemFont(ofSize: 16.0),
                              defaultTextColor:UIColor = .white,
                              defaultBackgroudColor:UIColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7),
                              actionURLSchemeWhiteList:[String] = [],
                              actionCallback:@escaping (_ u:URL)->() = {_ in}) {
        
        XSBaseToastManager.sharedInstance.schemeWhiteList = actionURLSchemeWhiteList
        XSBaseToastManager.sharedInstance.displaySecond = time
        XSBaseToastManager.sharedInstance.defaultFont = defaultFont
        XSBaseToastManager.sharedInstance.defaultTextColor = defaultTextColor
        XSBaseToastManager.sharedInstance.onActionCallback = actionCallback
        XSBaseToastManager.sharedInstance.defaultBackgroudColor = defaultBackgroudColor
    }
}
