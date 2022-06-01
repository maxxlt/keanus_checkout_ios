//
//  ScannerSettingsView.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/31/22.
//

import Combine
import UIKit
import BetterSegmentedControl

class ScannerSettingsView: UIView {
    // MARK: - Public APIs
    var actionPublisher = PassthroughSubject<Action, Never>()
    
    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setup()
    }
    required init?(coder: NSCoder) { nil }
    
    
    private func setup() {
        backgroundColor = .white
        constrain()
    }
    
    private func constrain(){
        backButton.snp.makeConstraints {
            $0.top.equalTo(self).offset(64)
            $0.left.equalTo(self).offset(32)
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        image.snp.makeConstraints {
            $0.top.equalTo(backButton).offset(32)
            $0.centerX.equalTo(self)
            $0.height.width.equalTo(200)
        }
        title.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(16)
            $0.left.equalTo(backButton)
            $0.right.equalTo(self).offset(-32)
        }
        subtitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.left.right.equalTo(title)
        }
        colorControl.snp.makeConstraints {
            $0.top.equalTo(subtitle.snp.bottom).offset(16)
            $0.left.right.equalTo(subtitle)
            $0.height.equalTo(54)
        }
        duplexControl.snp.makeConstraints {
            $0.top.equalTo(colorControl.snp.bottom).offset(8)
            $0.left.right.equalTo(subtitle)
            $0.height.equalTo(54)
        }
    }
    
    // MARK: - Private members
    @objc private func helloButtonTapped() {
        actionPublisher.send(.action1)
    }
    
    // MARK: - Lazy Loads
    lazy var backButton: ClingstoneButton = {
        let button = ClingstoneButton()
        button.setImage(.named(.left), for: .normal)
        button.tintColor = .black
        addSubview(button)
        return button
    }()
    private lazy var image: UIImageView = {
        let iv = UIImageView(image: .named(.surfer_1))
        iv.contentMode = .scaleAspectFit
        addSubview(iv)
        return iv
    }()
    private lazy var title: ClingstoneLabel = {
        let label = ClingstoneLabel(
            "Scanning Options",
            type: .h2_semibold
        )
        addSubview(label)
        return label
    }()
    private lazy var subtitle: ClingstoneLabel = {
        let label = ClingstoneLabel(
            "You will find some great scanner options below. Let's SURF by them",
            type: .h3_regular,
            align: .left,
            numLines: 3
        )
        addSubview(label)
        return label
    }()
    private lazy var colorControl: BetterSegmentedControl = {
        let control = BetterSegmentedControl()
        control.segments = LabelSegment.segments(
            withTitles: ["Color", "Speed Color", "Gray Scale"],
            normalFont: ClingstoneLabelType.body_thin.font,
            selectedFont: ClingstoneLabelType.body_bold.font,
            selectedTextColor: .white
        )
        control.setOptions([
            .cornerRadius(10),
            .animationSpringDamping(1.0),
            .indicatorViewBackgroundColor(ClingstonePalette.green.color)
        ])
        addSubview(control)
        return control
    }()
    private lazy var duplexControl: BetterSegmentedControl = {
        let control = BetterSegmentedControl()
        control.segments = LabelSegment.segments(
            withTitles: ["Duplex Off", "Duplex Long", "Duplex Short"],
            normalFont: ClingstoneLabelType.body_thin.font,
            selectedFont: ClingstoneLabelType.body_bold.font,
            selectedTextColor: .white
        )
        control.setOptions([
            .cornerRadius(10),
            .animationSpringDamping(1.0),
            .indicatorViewBackgroundColor(ClingstonePalette.green.color)
        ])
        addSubview(control)
        return control
    }()
}

extension ScannerSettingsView {
    enum Action {
        case action1
        case action2
    }
}

