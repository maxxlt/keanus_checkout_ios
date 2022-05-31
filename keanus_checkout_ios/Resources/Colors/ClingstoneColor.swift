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
case blue, green
    public var color: UIColor {
        switch self {
            case .blue:
                return UIColor(named: "blue")!
            case .green:
                return UIColor(named: "green")!
        }
    }
}
