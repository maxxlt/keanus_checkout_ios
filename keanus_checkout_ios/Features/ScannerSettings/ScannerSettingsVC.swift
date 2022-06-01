//
//  ScannerSettingsVC.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/31/22.
//

import Combine
import UIKit
import CombineCocoa
import BRScanKit

class ScannerSettingsVC: UIViewController {
    
    // MARK: - Inits
    init(selectedScanner: BRScanDevice) {
        self.selectedScanner = selectedScanner
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Overrides
    override func loadView() {
        view = customView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupBindings()
    }
    
    private func setupBindings() {
        observables = [
            customView.backButton
                .tapPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    self?.navigationController?
                        .popViewController(animated: true)
                }
        ]
    }
    
    // MARK: - Private vars
    private var observables = Set<AnyCancellable>()
    private var selectedScanner: BRScanDevice
    
    // MARK: - Private methods
    
    // MARK: - Lazy vars
    private lazy var customView: ScannerSettingsView = {
        ScannerSettingsView()
    }()
    private lazy var vm: ScannerSettingsVM = {
        ScannerSettingsVM(selectedScanner: self.selectedScanner)
    }()
}
