//
//  XSBaseToastWindow.swift
//  ProjectKit
//
//  Created by ZB-YF-HXS on 2021/3/14.
//

import UIKit

open class XSBaseToastWindow: UIWindow {

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let controller:XSBaseToastProtocol = rootViewController as! XSBaseToastProtocol
        let mViewRect:CGRect = controller.contentView.frame
        
        if mViewRect.contains(point) {
            return true
        }
        return false
    }
    
    static func createWindow(level:XSBaseToastLevelValue,
                             controller:XSBaseToastBaseViewController<XSBaseToastContentView>) -> XSBaseToastWindow{
        
        let windowLevel = UIWindow.Level.alert + UIWindow.Level.RawValue(level.rawValue)
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared
                            .connectedScenes
                            .filter { $0.activationState == .foregroundActive }
                            .first
            if let windowScene = windowScene as? UIWindowScene {
                let alertWindow = XSBaseToastWindow.init(windowScene: windowScene)
                alertWindow.frame = UIScreen.main.bounds
                alertWindow.backgroundColor = .clear
                alertWindow.windowLevel = windowLevel
                alertWindow.rootViewController = controller
                return alertWindow
            }
            return XSBaseToastWindow.init()
        }
        else{
            
            let alertWindow = XSBaseToastWindow.init(frame: UIScreen.main.bounds)
            // 保持永远在最上层
            alertWindow.windowLevel = windowLevel
            alertWindow.backgroundColor = .clear
            alertWindow.rootViewController = controller
            return alertWindow
        }
    }
    
    @available(iOS 13.0, *)
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
