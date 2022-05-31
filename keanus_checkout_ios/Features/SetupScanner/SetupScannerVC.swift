//
//  SetupScannerVC.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/30/22.
//

import Combine
import UIKit
import BRScanKit
import CombineCocoa

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
        _ = ProcessInfo.processInfo.hostName
        brotherBrowser.delegate = self
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vm.brotherDevices.removeAll()
        brotherBrowser.search()
    }
    override func viewWillDisappear(_ animated: Bool) {
        brotherBrowser.stop()
    }
    
    private func setupBindings() {
        observables = [
            // TODO: add your observables here
            vm.$state
                .receive(on: DispatchQueue.main)
                .sink { [weak self] state in
                    switch state {
                        case .loading:
                            self?.customView.loadingView.isHidden = false
                            self?.customView.doneView.isHidden = true
                            print("loading")
                        case .done:
                            self?.customView.loadingView.isHidden = true
                            self?.customView.table.reloadData()
                            self?.customView.doneView.isHidden = false
                        case .error:
                            break
                    }
                },
            vm.$scannerSelected
                .receive(on: DispatchQueue.main)
                .assign(to: \.isEnabled, on: customView.doneButton),
            customView.doneButton
                .tapPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    // TODO: push new VC here
                },
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
    private let brotherBrowser = BRScanDeviceBrowser()
    private var currScannerIndex: Int?
    
    
    // MARK: - Private methods
    
    // MARK: - Lazy vars
    private lazy var customView: SetupScannerView = {
        SetupScannerView(tableDel: self, tableDataSource: self)
    }()
    private lazy var vm: SetupScannerVM = {
        SetupScannerVM()
    }()
}

extension SetupScannerVC: BRScanDeviceBrowserDelegate {
    func scanDeviceBrowser(_ browser: BRScanDeviceBrowser!, didFind device: BRScanDevice!) {
        vm.brotherDevices.append(device)
    }
    
    func scanDeviceBrowser(_ browser: BRScanDeviceBrowser!, didRemove device: BRScanDevice!) {
        guard let index = vm.brotherDevices.firstIndex(of: device) else { return }
        
        vm.brotherDevices.remove(at: index)
    }
}

extension SetupScannerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.brotherDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "scannerCell",
            for: indexPath
        ) as! ScannerCell
        guard let model = vm.brotherDevices[indexPath.row].modelName else {
            return cell
        }
        var printerImage: UIImage?
        switch model {
            case "Brother DS-940DW": printerImage = .named(.brother_ds940dw)
            default: break
        }
        let modifiedTitle = model.replacingOccurrences(of: "Brother ", with: "")
        cell.configure(
            image: printerImage,
            title: modifiedTitle
        )
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.scannerSelected = true
        self.currScannerIndex = indexPath.row
    }
}
