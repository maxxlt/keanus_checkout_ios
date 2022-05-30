//
//  ClingstoneColor.swift
//  Keanu's Checkout
//
//  Created by Max Chan on 5/30/22.
//

import UIKit

protocol ClingstoneColor {
    var color: UIColor { get }
}

public enum ClingstonePalette: ClingstoneColor {
case red, pink, yellow, green, black
    public var color: UIColor {
        switch self {
            case .red:
                return UIColor(named: "red")!
            case .pink:
                return UIColor(named: "pink")!
            case .yellow:
                return UIColor(named: "yellow")!
            case .green:
                return UIColor(named: "green")!
            case .black:
                return UIColor(named: "black")!
        }
    }
}
