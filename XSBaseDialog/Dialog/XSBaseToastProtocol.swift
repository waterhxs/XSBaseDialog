//
//  XSBaseToastProtocol.swift
//  ProjectKit
//
//  Created by ZB-YF-HXS on 2021/3/14.
//

import Foundation
import UIKit

protocol XSBaseToastProtocol {
    
    /// 容器类
    var contentView:XSBaseToastContainerView { get set }
    
    /// 显示的时间
    var displayTimeSecond:Int {get set}
    
    /// 信息
    var currMessage:NSMutableAttributedString {get set}
    
    /// 需要反馈的白名单
    var currURLSchmemWhiteList:[String] {get set}
    
    /// 显示
    /// - Parameter message: 需要显示的富媒体
    func show(message: NSMutableAttributedString)
    
    /// 关闭
    func close()
    
    /// 设置背景颜色
    /// - Parameter color: 背景颜色
    func setBackgroudColor(color:UIColor)
    
    func handleURL(callback: @escaping (URL) -> ())
}
