//
//  ScannerSettingsView.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/31/22.
//

import Combine
import UIKit

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
        title.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(16)
            $0.left.equalTo(backButton)
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
    private lazy var title: ClingstoneLabel = {
        let label = ClingstoneLabel(
            "Printing Options",
            type: .h2_semibold
        )
        addSubview(label)
        return label
    }()
}

extension ScannerSettingsView {
    enum Action {
        case action1
        case action2
    }
}

