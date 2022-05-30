//
//  SetupScannerView.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/30/22.
//

import Combine
import UIKit

class SetupScannerView: UIView {
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
        helloButton.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Private members
    @objc private func helloButtonTapped() {
        actionPublisher.send(.action1)
    }
    
    // MARK: - Lazy Loads
    private lazy var helloButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hello", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.addTarget(
            self,
            action: #selector(helloButtonTapped),
            for: .touchUpInside
        )
        addSubview(button)
        return button
    }()
}

extension SetupScannerView {
    enum Action {
        case action1
        case action2
    }
}

