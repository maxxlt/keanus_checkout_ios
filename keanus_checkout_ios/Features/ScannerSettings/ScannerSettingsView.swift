//
//  ScannerSettingsView.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/31/22.
//

import Combine
import UIKit
import BetterSegmentedControl
import Switches

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
        blankPageTitle.snp.makeConstraints {
            $0.top.equalTo(duplexControl.snp.bottom).offset(16)
            $0.left.equalTo(duplexControl)
            $0.right.equalTo(blankPageSwitch.snp.left).offset(-8)
        }
        blankPageSwitch.snp.makeConstraints {
            $0.centerY.equalTo(blankPageTitle)
            $0.right.equalTo(duplexControl)
            $0.width.equalTo(80)
        }
        sizePromptText.snp.makeConstraints {
            $0.top.equalTo(blankPageSwitch.snp.bottom).offset(16)
            $0.left.right.equalTo(duplexControl)
        }
        sizeTextField.snp.makeConstraints {
            $0.top.equalTo(sizePromptText.snp.bottom).offset(8)
            $0.left.right.equalTo(duplexControl)
            $0.height.equalTo(54)
            $0.bottom.equalTo(scanBtn.snp.top).offset(-16)
        }
        scanBtn.snp.makeConstraints {
            $0.bottom.equalTo(self).offset(-32)
            $0.left.right.equalTo(duplexControl)
            $0.height.equalTo(54)
        }
    }
    
    // MARK: - Private members
    @objc private func helloButtonTapped() {
        actionPublisher.send(.action1)
    }
    let paperSizes = ["Auto Size", "Photo L", "Photo", "Business Card", "JIS B5",
                      "A4", "Letter", "Legal", "JIS B4", "Ledger", "A3"]
    
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
    lazy var colorControl: BetterSegmentedControl = {
        let control = BetterSegmentedControl()
        control.segments = LabelSegment.segments(
            withTitles: ["Color", "Speed Color", "Gray Scale"],
            normalFont: ClingstoneLabelType.body_thin.font,
            selectedFont: ClingstoneLabelType.body_regular.font,
            selectedTextColor: .white
        )
        control.setOptions([
            .cornerRadius(10),
            .animationSpringDamping(1.0),
            .indicatorViewBackgroundColor(ClingstonePalette.cyan.color)
        ])
        addSubview(control)
        return control
    }()
    lazy var duplexControl: BetterSegmentedControl = {
        let control = BetterSegmentedControl()
        control.segments = LabelSegment.segments(
            withTitles: ["Duplex Off", "Duplex Long", "Duplex Short"],
            normalFont: ClingstoneLabelType.body_thin.font,
            selectedFont: ClingstoneLabelType.body_regular.font,
            selectedTextColor: .white
        )
        control.setOptions([
            .cornerRadius(10),
            .animationSpringDamping(1.0),
            .indicatorViewBackgroundColor(ClingstonePalette.cyan.color)
        ])
        addSubview(control)
        return control
    }()
    private lazy var blankPageTitle: ClingstoneLabel = {
        let label = ClingstoneLabel(
            "Skip blank page?",
            type: .h3_regular
        )
        addSubview(label)
        return label
    }()
    lazy var blankPageSwitch: YapSwitch = {
        let switcher = YapSwitch()
        switcher.onTintColor = ClingstonePalette.cyan.color
        addSubview(switcher)
        return switcher
    }()
    private lazy var sizePromptText: ClingstoneLabel = {
        let label = ClingstoneLabel(
            "Select Paper Size:",
            type: .h3_regular
        )
        addSubview(label)
        return label
    }()
    lazy var sizeTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = paperSizes[0]
        textfield.textAlignment = .center
        textfield.borderStyle = .roundedRect
        textfield.tintColor = .clear
        textfield.inputView = sizePicker
        textfield.font = ClingstoneLabelType.body_regular.font
        addSubview(textfield)
        return textfield
    }()
    private lazy var sizePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    lazy var scanBtn: ClingstoneButton = {
        let button = ClingstoneButton()
        button.setTitle("Scan".uppercased(), for: .normal)
        button.titleLabel?.font = ClingstoneLabelType.body_regular.font
        button.backgroundColor = ClingstonePalette.blue.color
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        addSubview(button)
        return button
    }()
}

extension ScannerSettingsView {
    enum Action {
        case action1
        case action2
    }
}

extension ScannerSettingsView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.paperSizes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        paperSizes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sizeTextField.text = paperSizes[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = ClingstoneLabelType.h3_regular.font
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = paperSizes[row]
        return pickerLabel!
    }
}
