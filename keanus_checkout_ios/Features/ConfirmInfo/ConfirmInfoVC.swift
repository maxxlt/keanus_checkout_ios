//
//  ConfirmInfoVC.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 6/2/22.
//

import Combine
import UIKit
import CombineCocoa

class ConfirmInfoVC: UIViewController {
    
    var actionPublisher = PassthroughSubject<Action, Never>()
    
    // MARK: - Inits
    init(frame: CGRect, image: UIImage) {
        self.image = image
        self.parentFrame = frame
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Overrides
    override func loadView() {
        view = customView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        observables = [
            // TODO: add your observables here
            customView.actionPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] action in
                    switch action {
                        case .action1: break
                        case .action2: break
                    }
                },
            customView.cancelBtn
                .tapPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    self?.actionPublisher.send(.dismiss)
                }
        ]
    }
    
    // MARK: - Private vars
    private var observables = Set<AnyCancellable>()
    private let parentFrame: CGRect
    private let image: UIImage
    
    // MARK: - Private methods
    
    // MARK: - Lazy vars
    private lazy var customView: ConfirmInfoView = {
        ConfirmInfoView(
            parentFrame: parentFrame,
            image: image
        )
    }()
    private lazy var vm: ConfirmInfoVM = {
        ConfirmInfoVM()
    }()
}

extension ConfirmInfoVC {
    enum Action {
        case dismiss
    }
}
