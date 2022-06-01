//
//  ScannerSettingsVM.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/31/22.
//

import Combine
import BRScanKit

class ScannerSettingsVM {
    
    // MARK: - Public APIs
    enum State {
        case loading, done, error
    }
    
    // MARK: - Published vars
    @Published private(set) var state: State
    @Published private(set) var scanner: BRScanDevice
    
    // MARK: - Inits
    init(selectedScanner: BRScanDevice) {
        self.state = .loading
        self.scanner = selectedScanner
        configureOutput()
    }
    
    // MARK: - Private vars

    // MARK: - Private methods
    private func configureOutput() {
        
    }
}

