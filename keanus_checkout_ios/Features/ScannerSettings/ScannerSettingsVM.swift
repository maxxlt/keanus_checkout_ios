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
    enum ColorOption: Int {
        case color, colorHighSpeed, grayScale
        
        var type: UInt {
            switch self {
                case .color:
                    return BRScanJobOptionColorType.color.rawValue
                case .colorHighSpeed:
                    return BRScanJobOptionColorType.colorHighSpeed.rawValue
                case .grayScale:
                    return BRScanJobOptionColorType.grayscale.rawValue
            }
        }
    }
    enum DuplexOption: Int {
        case off, longEdge, shortEdge
        
        var type: UInt {
            switch self {
                case .off:
                    return BRScanJobOptionDuplex.off.rawValue
                case .longEdge:
                    return BRScanJobOptionDuplex.longEdge.rawValue
                case .shortEdge:
                    return BRScanJobOptionDuplex.shortEdge.rawValue
            }
        }
    }
    func prepareScanner() {
        let scanJob = BRScanJob(ipAddress: scanner.ipAddress)
        var jobOptions = [String: UInt]()
        jobOptions[BRScanJobOptionColorTypeKey] = colorOption.type
        jobOptions[BRScanJobOptionDocumentSizeKey] = docSizeOption
        jobOptions[BRScanJobOptionDuplexKey] = duplexOption.type
        jobOptions[BRScanJobOptionSkipBlankPageKey] = skipBlankPage ? 1 : 0
        scanJob?.options = jobOptions
        self.scanJob = scanJob
    }
    
    // MARK: - Published vars
    @Published private(set) var state: State
    @Published private(set) var scanner: BRScanDevice
    @Published var colorOption: ColorOption = .color
    @Published var duplexOption: DuplexOption = .off
    @Published var docSizeOption: UInt = 0
    @Published var skipBlankPage: Bool = false
    @Published private(set) var scanJob: BRScanJob?
    
    
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

