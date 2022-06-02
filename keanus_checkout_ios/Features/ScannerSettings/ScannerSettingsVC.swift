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
import SwiftSpinner
import Vision

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
        scanJob.delegate = self
    }
    
    private func setupBindings() {
        observables = [
            customView.backButton
                .tapPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    self?.navigationController?
                        .popViewController(animated: true)
                },
            customView.colorControl
                .controlEventPublisher(for: .allEvents)
                .receive(on: DispatchQueue.main)
                .sink {
                    self.vm.colorOption = .init(rawValue: self.customView.colorControl.index) ?? .color
                },
            customView.duplexControl
                .controlEventPublisher(for: .allEvents)
                .receive(on: DispatchQueue.main)
                .sink {
                    self.vm.duplexOption = .init(
                        rawValue: self.customView.duplexControl.index
                    ) ?? .off
                },
            customView.blankPageSwitch
                .controlEventPublisher(for: .touchUpInside)
                .receive(on: DispatchQueue.main)
                .sink {
                    self.vm.skipBlankPage = self.customView.blankPageSwitch.isOn
                },
            customView.sizeTextField
                .textPublisher
                .receive(on: DispatchQueue.main)
                .sink { text in
                    if let text = text {
                        self.vm.docSizeOption = UInt(
                            self.customView.paperSizes.firstIndex(of: text) ?? 0
                        )
                    }
                },
            customView.scanBtn
                .tapPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    self?.vm.prepareScanner()
                },
            vm.$scanJob
                .receive(on: DispatchQueue.main)
                .sink { [weak self] scanJob in
                    self?.scan(scanJob: scanJob)
                }
        ]
    }
    
    // MARK: - Private vars
    private var observables = Set<AnyCancellable>()
    private var selectedScanner: BRScanDevice
    private var scanJob =  BRScanJob()
    private var scannedImages = [UIImage]()
    
    // MARK: - Private methods
    private func scan(scanJob: BRScanJob?) {
        if let scanJob = scanJob {
            scanJob.delegate = self
            scanJob.start()
        }
    }
    private func analyze(image: UIImage){
        guard let cgImage = image.cgImage else { return }
        
        DispatchQueue.main.async { [weak self] in
            let request = VNRecognizeTextRequest(completionHandler: self?.handleDetectedText)
            // Slowest but most accurate OCR
            request.recognitionLevel = .accurate
            request.recognitionLanguages = ["en-US", "en-GB"]
            // The Vision framework will use grammar and spell-checking to improve accuracy
            request.usesLanguageCorrection = true
            
            let requests = [request]
            let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: .up, options: [:])
            
            do {
                try imageRequestHandler.perform(requests)
            } catch let error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    private func handleDetectedText(request: VNRequest?, error: Error?) {
        if let error = error {
            print("ERROR: \(error)")
            return
        }
        guard let results = request?.results, results.count > 0 else {
            print("No text found")
            return
        }

        // Run this in a simulator and examine the console output to learn more
        var docText = ""
        var summedConfidence: Float = 0.0
        for result in results {
            if let observation = result as? VNRecognizedTextObservation {
                for text in observation.topCandidates(1) {
                    print(text.string)
                    print(text.confidence)
                    print(observation.boundingBox)
                    print("\n")
                    
                    docText += text.string + "\n"
                    summedConfidence += text.confidence
                }
                
//                confidenceScoreLabel.text = "Confidence Score: \(summedConfidence / Float(results.count))"
//                ocrTextView.text = docText
//                busyIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: - Lazy vars
    private lazy var customView: ScannerSettingsView = {
        ScannerSettingsView()
    }()
    private lazy var vm: ScannerSettingsVM = {
        ScannerSettingsVM(selectedScanner: self.selectedScanner)
    }()
}

extension ScannerSettingsVC: BRScanJobDelegate {
    
    // Periodically update progress during the scanning process. For multipage scans the
    // progress indicator will step backwards and may even exceed 0.0 ... 1.0
    func scanJob(_ job: BRScanJob!, progress: Float) {
        DispatchQueue.main.async { [weak self] in
            guard progress <= 1 else { return }
//            self?.scanProgressView.setProgress(progress, animated: true)
        }
    }
    
    // Process your scanned image with this method. For visual interest, this demo updates the
    // UIImageView with the last scanned image.
    func scanJob(_ job: BRScanJob!, didFinishPage path: String!) {
        DispatchQueue.main.async { [weak self] in
            if let scannedImage = UIImage(contentsOfFile: path) {
                self?.scannedImages.append(scannedImage)
//                self?.imageIndexStepper.maximumValue = Double(self?.scannedImages.count ?? 0)
//                self?.scannedImageView.image = scannedImage
                if let scannedImage = self?.scannedImages[0] {
                    self?.analyze(image: scannedImage)
                }
            }
        }
    }
    
    // Report the result of the scanning job and handle end of job activities here.
    // Notice that this is non-throwing. Examine the BRScanJobResult enum for status and errors.
    func scanJobDidFinish(_ job: BRScanJob!, result: BRScanJobResult) {
        guard job.filePaths.count > 0 else { return }
        SwiftSpinner.hide()
        defer {
            DispatchQueue.main.async { [weak self] in
//                self?.scanProgressView.isHidden = true
//                self?.scannedImageView.image = self?.scannedImages[0]
                print("Job result code: \(result.rawValue)")
            }
        }
        
        // Do something interesting here
        print("Scanned pages: \(job.filePaths.count)")
    }
}
