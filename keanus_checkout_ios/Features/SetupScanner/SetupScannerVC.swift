//
//  SetupScannerVC.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/30/22.
//

import Combine
import UIKit

class SetupScannerVC: UIViewController {
    
    // MARK: - Inits
    init() {
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
                }
        ]
    }
    
    // MARK: - Private vars
    private var observables = Set<AnyCancellable>()
    
    // MARK: - Private methods
    
    // MARK: - Lazy vars
    private lazy var customView: SetupScannerView = {
        SetupScannerView()
    }()
    private lazy var vm: SetupScannerVM = {
        SetupScannerVM()
    }()
}
