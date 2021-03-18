//
//  XSBaseToastBaseViewController.swift
//  ProjectKit
//
//  Created by ZB-YF-HXS on 2021/3/14.
//

import UIKit

open class XSBaseToastBaseViewController<XSBaseToastContentView:UIView>: UIViewController {
    
    lazy public var safeAreaInsets:UIEdgeInsets = {
        if #available(iOS 13.0, *) {
            let insets:UIEdgeInsets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
            return insets
        }
        else{
            return UIEdgeInsets.zero
        }
    }()
    
    var container: XSBaseToastContentView {
        view as! XSBaseToastContentView
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func loadView() {
        super.loadView()
        if view is XSBaseToastContentView {
            return
        }
        view = XSBaseToastContentView.init()
    }

}
