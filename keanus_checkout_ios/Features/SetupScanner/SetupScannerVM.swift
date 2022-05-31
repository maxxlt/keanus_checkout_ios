//
//  SetupScannerVM.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/30/22.
//

import Combine
import BRScanKit

class SetupScannerVM {
    
    // MARK: - Public APIs
    enum State {
        case loading, done, error
    }
    
    // MARK: - Published vars
    @Published var state: State
    @Published var brotherDevices = [BRScanDevice]() {
        didSet {
            if brotherDevices.count > 0 {
                state = .done
            } else {
                state = .loading
            }
        }
    }
    @Published var scannerSelected: Bool = false
    
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

