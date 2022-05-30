//
//  ClingstoneLabel.swift
//  Keanu's Checkout
//
//  Created by Max Chan on 5/30/22.
//

import UIKit

enum ClingstoneLabelType {
    case h0_bold
    case h1_bold
    case h1_regular
    case h2_semibold
    case h2_thin
    case h2_regular
    case h3_regular
    case h3_thin_italic
    case h3_bold
    case body_regular
    case body_bold
    case body_italic
    case body_thin

    var font: UIFont {
        switch self {
            case .h0_bold: return .nutriMontserratRomanBold(30)!
            case .h1_bold: return .nutriMontserratRomanBold(28)!
            case .h1_regular: return .nutriMontserratRomanRegular(28)!
            case .h2_semibold: return .nutriMontserratRomanSemiBold(24)!
            case .h2_thin: return .nutriMontserratThin(24)!
            case .h2_regular: return .nutriMontserratRomanRegular(24)!
            case .h3_regular: return .nutriMontserratRomanRegular(20)!
            case .h3_bold: return .nutriMontserratRomanBold(20)!
            case .h3_thin_italic: return .nutriMontserratThinItalic(20)!
            case .body_regular: return .nutriMontserratRomanRegular(16)!
            case .body_bold: return .nutriMontserratRomanBold(16)!
            case .body_italic: return .nutriMontserratItalicRegular(16)!
            case .body_thin: return .nutriMontserratThin(16)!
        }
    }
}

class ClingstoneLabel: UILabel {
    // MARK: Inits
    init(_ text: String? = nil,
         type: ClingstoneLabelType,
         textColor: UIColor = .black,
         align: NSTextAlignment = .left,
         numLines: Int = 1
    ) {
        super.init(frame: .zero)
        self.text = text
        self.font = type.font
        self.textColor = textColor
        self.textAlignment = align
        self.numberOfLines = numLines
    }
    required init?(coder: NSCoder) { return nil }
    
    // MARK: Overrides
    
    // MARK: Private members
}
