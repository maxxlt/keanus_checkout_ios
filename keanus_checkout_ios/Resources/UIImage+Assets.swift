//
//  UIImage+Assets.swift
//  Keanu's Checkout
//
//  Created by Max Chan on 5/30/22.
//

import UIKit

extension UIImage {
    static func named(_ name: ImageAssetName) -> UIImage {
        return UIImage(named: name.rawValue) ?? UIImage()
    }
}

enum ImageAssetName: String, CaseIterable {
    case surfer_5 = "surfer 5"
    case placeholder
    case checkmark
    case brother_ds940dw
    case left
}
