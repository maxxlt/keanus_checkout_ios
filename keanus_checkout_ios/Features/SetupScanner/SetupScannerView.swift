//
//  SetupScannerView.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/30/22.
//

import Combine
import UIKit

class SetupScannerView: UIView {
    // MARK: - Public APIs
    var actionPublisher = PassthroughSubject<Action, Never>()
    
    // MARK: - Inits
    init(
        tableDel: UITableViewDelegate,
        tableDataSource: UITableViewDataSource
    ) {
        self.tableDel = tableDel
        self.tableDataSource = tableDataSource
        super.init(frame: .zero)
        setup()
    }
    required init?(coder: NSCoder) { nil }
    
    
    private func setup() {
        backgroundColor = .white
        constrain()
    }
    
    private func constrain(){
        image.snp.makeConstraints {
            $0.top.equalTo(self).offset(64)
            $0.centerX.equalTo(self)
            $0.height.width.equalTo(200)
        }
        title.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(32)
            $0.left.equalTo(self).offset(32)
            $0.right.equalTo(self).offset(-32)
        }
        loadingView.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(title.snp.bottom)
            $0.bottom.equalTo(self)
        }
        emptyView.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(title.snp.bottom)
            $0.bottom.equalTo(self)
        }
        emptyTitle.snp.makeConstraints {
            $0.centerY.equalTo(emptyView).offset(-16)
            $0.centerX.equalTo(emptyView)
        }
        doneView.snp.makeConstraints {
            $0.left.right.equalTo(title)
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.bottom.equalTo(self)
        }
        table.snp.makeConstraints {
            $0.top.left.right.equalTo(doneView)
            $0.bottom.equalTo(doneButton.snp.top).offset(-16)
        }
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(doneView).offset(-32)
            $0.left.right.equalTo(doneView)
            $0.height.equalTo(54)
        }
    }
    
    // MARK: - Private members
    private let tableDel: UITableViewDelegate
    private let tableDataSource: UITableViewDataSource
    
    // MARK: - Lazy Loads
    private lazy var image: UIImageView = {
        let iv = UIImageView(image: .named(.surfer_5))
        iv.contentMode = .scaleAspectFit
        addSubview(iv)
        return iv
    }()
    private lazy var title: ClingstoneLabel = {
        let label = ClingstoneLabel(
            "Let's setup your Brother scanner",
            type: .h2_semibold,
            align: .center,
            numLines: 2
        )
        addSubview(label)
        return label
    }()
    lazy var loadingView: Loading = {
        let view = Loading(withTitle: "Searching for scanners..")
        addSubview(view)
        return view
    }()
    lazy var emptyView: UIView = {
        let view = UIView()
        view.isHidden = true
        addSubview(view)
        return view
    }()
    private lazy var emptyTitle: ClingstoneLabel = {
        let label = ClingstoneLabel(
            "No scanners found yet.",
            type: .h3_regular
        )
        emptyView.addSubview(label)
        return label
    }()
    lazy var doneView: UIView = {
        let view = UIView()
        addSubview(view)
        return view
    }()
    lazy var table: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.bounces = false
        table.rowHeight = 200
        table.register(
            ScannerCell.self,
            forCellReuseIdentifier: "scannerCell"
        )
        table.delegate = self.tableDel
        table.dataSource = self.tableDataSource
        table.rowHeight = UITableView.automaticDimension
        doneView.addSubview(table)
        return table
    }()
    lazy var doneButton: ClingstoneButton = {
        let button = ClingstoneButton()
        button.setTitle("Done".uppercased(), for: .normal)
        button.titleLabel?.font = ClingstoneLabelType.body_regular.font
        button.backgroundColor = ClingstonePalette.blue.color
        doneView.addSubview(button)
        return button
    }()
}

extension SetupScannerView {
    enum Action {
        case action1
        case action2
    }
}

