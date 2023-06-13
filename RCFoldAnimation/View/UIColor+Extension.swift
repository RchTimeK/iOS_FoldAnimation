//
//  UIColor+Extension.swift
//  HZBuildSwift
//
//  Created by RongCheng on 2023/4/11.
//
import UIKit

extension UIColor {
    static let theme: UIColor = hexString("1BAEF1")
    static let c1: UIColor = hexString("111111")
    static let c2: UIColor = hexString("222222")
    static let c3: UIColor = hexString("333333")
    static let c4: UIColor = hexString("444444")
    static let c5: UIColor = hexString("555555")
    static let c6: UIColor = hexString("666666")
    static let c7: UIColor = hexString("777777")
    static let c8: UIColor = hexString("888888")
    static let c9: UIColor = hexString("999999")
    static let cA: UIColor = hexString("AAAAAA")
    static let cB: UIColor = hexString("BBBBBB")
    static let cC: UIColor = hexString("CCCCCC")
    static let cD: UIColor = hexString("DDDDDD")
    static let cE: UIColor = hexString("EEEEEE")
    static let cF7: UIColor = hexString("F7F7F7")
    static let cRed: UIColor = hexString("FF4053")
    
    static func hexString(_ string: String) -> UIColor {
        var tempStr = string
        if tempStr.hasPrefix("#") {
            tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 1)...])
        }
        assert(tempStr.count == 6, "颜色位数错误")
        
        var red: UInt64 = 0, green: UInt64 = 0, blue: UInt64 = 0
        
        Scanner(string: String(tempStr[..<tempStr.index(tempStr.startIndex, offsetBy: 2)])).scanHexInt64(&red)
        
        Scanner(string: String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 2)..<tempStr.index(tempStr.startIndex, offsetBy: 4)])).scanHexInt64(&green)
        
        Scanner(string: String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 4)...])).scanHexInt64(&blue)
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    static func randomColor() -> UIColor {
        let red = arc4random() % 255
        let green = arc4random() % 255
        let blue = arc4random() % 255
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue:  CGFloat(blue)/255.0, alpha: 1.0)
    }
}
