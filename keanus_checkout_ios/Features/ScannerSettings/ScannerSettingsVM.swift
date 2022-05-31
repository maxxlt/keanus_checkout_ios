//
//  ScannerSettingsVM.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/31/22.
//

import Combine

class ScannerSettingsVM {
    
    // MARK: - Public APIs
    enum State {
        case loading, done, error
    }
    
    // MARK: - Published vars
    @Published private(set) var state: State
    
    // MARK: - Inits
    init() {
        self.state = .loading
        configureOutput()
    }
    
    // MARK: - Private vars

    // MARK: - Private methods
    private func configureOutput() {
        
    }
}

