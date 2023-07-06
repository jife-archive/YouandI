//
//  Colors.swift
//  You&I
//
//  Created by 최지철 on 2023/06/24.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    class var MainBackground: UIColor { UIColor(named: "MainBackground") ?? UIColor() }
    class var barColor: UIColor { UIColor(named: "barColor") ?? UIColor() }
    class var mainContainer: UIColor { UIColor(named: "mainContainer") ?? UIColor() }
    class var ContinerPink: UIColor { UIColor(named: "ContinerPink") ?? UIColor() }
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
  
}
