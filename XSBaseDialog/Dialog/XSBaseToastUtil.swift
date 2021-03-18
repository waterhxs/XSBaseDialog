//
//  XSBaseToastUtil.swift
//  ProjectKit
//
//  Created by ZB-YF-HXS on 2021/3/14.
//

import UIKit

class XSBaseToastUtil: NSObject {

    static func windowWithLevel(level:UIWindow.Level) -> UIWindow {
        
        let windows = UIApplication.shared.windows
        for window in windows {
            if window.windowLevel == level {
                return window
            }
        }
        
        return UIWindow.init()
    }
}
