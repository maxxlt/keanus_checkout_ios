//
//  ScannerCell.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/30/22.
//

import UIKit

class ScannerCell: UITableViewCell {
    // MARK: Public APIs
    func configure(image: UIImage?, title: String) {
        if let image = image {
            self.image.image = image
        }
        self.title.text = title
    }
    
    // MARK: Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) { return nil }
    
    private func setup() {
        constrain()
    }
    
    private func constrain() {
        background.snp.makeConstraints {
            $0.right.left.top.equalTo(self)
            $0.bottom.equalTo(self).offset(-8)
        }
        image.snp.makeConstraints {
            $0.left.equalTo(background).offset(8)
            $0.top.equalTo(background).offset(16)
            $0.bottom.equalTo(background).offset(-16)
            $0.right.equalTo(background.snp.centerX).offset(-32)
        }
        title.snp.makeConstraints {
            $0.left.equalTo(image.snp.right)
            $0.right.equalTo(checkmark.snp.left).offset(-16)
            $0.centerY.equalTo(background)
        }
        checkmark.snp.makeConstraints {
            $0.right.equalTo(background).offset(-32)
            $0.centerY.equalTo(background)
            $0.height.width.equalTo(24)
        }
    }
    
    // MARK: Overrides
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            checkmark.isHidden = false
            background.layer.borderColor = ClingstonePalette.green.color.cgColor
            background.layer.borderWidth = 2
            title.font = ClingstoneLabelType.body_bold.font
            title.textColor = ClingstonePalette.green.color
            
        } else {
            checkmark.isHidden = true
            background.layer.borderColor = UIColor.black.cgColor
            background.layer.borderWidth = 1
            title.font = ClingstoneLabelType.body_regular.font
            title.textColor = .black
        }
    }

    // MARK: Private members
    
    // MARK: Lazy loads
    private lazy var background: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        contentView.addSubview(view)
        return view
    }()
    private lazy var image: UIImageView = {
        let iv = UIImageView(image: .named(.placeholder))
        iv.contentMode = .scaleAspectFit
        background.addSubview(iv)
        return iv
    }()
    private lazy var title: ClingstoneLabel = {
        let label = ClingstoneLabel(nil, type: .body_regular)
        background.addSubview(label)
        return label
    }()
    private lazy var checkmark: UIImageView = {
        let iv = UIImageView(
            image: .named(.checkmark)
                .withColor(ClingstonePalette.green.color)
        )
        iv.contentMode = .scaleAspectFit
        background.addSubview(iv)
        return iv
    }()
}
