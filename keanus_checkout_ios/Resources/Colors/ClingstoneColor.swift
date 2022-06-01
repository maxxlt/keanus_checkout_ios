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
case blue, green, cyan
    public var color: UIColor {
        switch self {
            case .blue:
                return UIColor(named: "blue")!
            case .green:
                return UIColor(named: "green")!
            case .cyan:
                return UIColor(named: "cyan")!
        }
    }
}
