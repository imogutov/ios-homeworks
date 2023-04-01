//
//  UIColorExtension.swift
//  Navigation
//
//  Created by Ivan Mogutov on 01.02.2023.
//

import Foundation
import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
