//
//  ClingstoneButton.swift
//  Keanu's Checkout
//
//  Created by Max Chan on 5/30/22.
//

import UIKit

class ClingstoneButton: UIButton {
    
    // MARK: Overrides
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted
            ? backgroundColor?.withAlphaComponent(0.7)
            : backgroundColor?.withAlphaComponent(1)
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled
            ? backgroundColor?.withAlphaComponent(1)
            : backgroundColor?.withAlphaComponent(0.3)
        }
    }
}
