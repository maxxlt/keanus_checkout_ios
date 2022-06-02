//
//  ConfirmInfoView.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 6/2/22.
//

import Combine
import UIKit

class ConfirmInfoView: UIView {
    // MARK: - Public APIs
    var actionPublisher = PassthroughSubject<Action, Never>()
    
    // MARK: - Inits
    init(parentFrame: CGRect) {
        self.parentFrame = parentFrame
        super.init(
            frame: CGRect(
                x: 0,
                y: 0,
                width: parentFrame.width,
                height: parentFrame.height
            )
        )
        setup()
    }
    required init?(coder: NSCoder) { nil }
    
    
    private func setup() {
        backgroundColor = .clear
        constrain()
    }
    
    private func constrain(){
        dialogContainer.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.width.equalTo(parentFrame.width*0.8)
        }
    }
    
    // MARK: - Private members
    private let parentFrame: CGRect
    
    // MARK: - Lazy Loads
    private lazy var dialogContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        addSubview(view)
        return view
    }()
}

extension ConfirmInfoView {
    enum Action {
        case action1
        case action2
    }
}
