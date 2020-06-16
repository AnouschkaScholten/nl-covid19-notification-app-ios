//
//  ENColors.swift
//  EN
//
//  Created by Cameron Mc Gorian on 16/06/2020.
//

import Foundation
import UIKit

public protocol Colors: AnyObject {
    var primary: UIColor { get }
    var secondary: UIColor { get }
    var tertiary: UIColor { get }
    
    var gray: UIColor { get }
    
    var ok: UIColor { get }
    var notified: UIColor { get }
    var inactive: UIColor { get }
    
    var statusGradientActive: UIColor { get }
    var statusGradienNotified: UIColor { get }
    
    var navigationControllerBackground: UIColor { get }
    var viewControllerBackground: UIColor { get }
}

final class ENColors: Colors {
    var primary: UIColor {
        return color(for: "theme.colors.primary")
    }
    
    var secondary: UIColor {
        return color(for: "SecondaryColor")
    }
    
    var tertiary: UIColor {
        return color(for: "TertiaryColor")
    }
    
    var gray: UIColor {
        return color(for: "GrayColor")
    }
    
    var ok: UIColor {
        return color(for: "OkGreen")
    }
    
    var notified: UIColor {
        return color(for: "NotifiedRed")
    }
    
    var inactive: UIColor {
        return color(for: "InactiveOrange")
    }
    
    var statusGradientActive: UIColor {
        return color(for: "StatusGradientBlue")
    }
    
    var statusGradienNotified: UIColor {
        return color(for: "StatusGradientRed")
    }
    
    var navigationControllerBackground: UIColor {
        return color(for: "NavigationControllerBackgroundColor")
    }
    
    var viewControllerBackground: UIColor {
        return color(for: "ViewControllerBackgroundColor")
    }
    
    // MARK: - Private
    
    private func color(for name: String) -> UIColor {
        if let color = UIColor(named: name) {
            return color
        }
        print("🔥 Color: \(name) not found")
        return .clear
    }
}
