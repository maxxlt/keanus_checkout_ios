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
    init(parentFrame: CGRect, image: UIImage) {
        self.parentFrame = parentFrame
        self.image = image
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
        imageView.snp.makeConstraints {
            $0.top.equalTo(dialogContainer).offset(32)
            $0.left.equalTo(dialogContainer).offset(32)
            $0.right.equalTo(dialogContainer).offset(-32)
            $0.height.equalTo(400)
        }
        cancelBtn.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.left.equalTo(imageView)
            $0.right.equalTo(dialogContainer.snp.centerX).offset(-8)
            $0.height.equalTo(54)
            $0.bottom.equalTo(dialogContainer).offset(-32)
        }
        confirmBtn.snp.makeConstraints {
            $0.top.equalTo(cancelBtn)
            $0.left.equalTo(dialogContainer.snp.centerX).offset(8)
            $0.right.equalTo(imageView)
            $0.height.equalTo(54)
        }
    }
    
    // MARK: - Private members
    private let parentFrame: CGRect
    private let image: UIImage
    
    // MARK: - Lazy Loads
    private lazy var dialogContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        addSubview(view)
        return view
    }()
    private lazy var imageView: UIImageView = {
        let iv = UIImageView(image: self.image)
        iv.contentMode = .scaleAspectFit
        dialogContainer.addSubview(iv)
        return iv
    }()
    lazy var cancelBtn: ClingstoneButton = {
        let button = ClingstoneButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.clipsToBounds = true
        button.titleLabel?.font = ClingstoneLabelType.body_bold.font
        dialogContainer.addSubview(button)
        return button
    }()
    lazy var confirmBtn: ClingstoneButton = {
        let button = ClingstoneButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = ClingstoneLabelType.body_bold.font
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.backgroundColor = ClingstonePalette.blue.color
        dialogContainer.addSubview(button)
        return button
    }()
}

extension ConfirmInfoView {
    enum Action {
        case action1
        case action2
    }
}
