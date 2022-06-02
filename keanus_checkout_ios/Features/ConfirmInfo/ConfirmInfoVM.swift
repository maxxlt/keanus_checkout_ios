//
//  ConfirmInfoVM.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 6/2/22.
//

import Combine

class ConfirmInfoVM {
    
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

