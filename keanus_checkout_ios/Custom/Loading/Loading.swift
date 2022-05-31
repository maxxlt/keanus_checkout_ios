//
//  Loading.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/30/22.
//

import Combine
import UIKit
import Lottie

class Loading: UIView {
    
    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setup()
    }
    required init?(coder: NSCoder) { nil }
    
    init(withTitle title: String) {
        super.init(frame: .zero)
        loadingTitle.text = title
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        constrain()
    }
    
    private func constrain(){
        loadingAnimatedImage.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.centerY.equalTo(self).offset(-16)
            $0.height.equalTo(200)
        }
        loadingTitle.snp.makeConstraints {
            $0.top.equalTo(loadingAnimatedImage.snp.bottom)
            $0.centerX.equalTo(loadingAnimatedImage)
        }
    }
    
    // MARK: - Overrides
    override var isHidden: Bool {
        didSet {
            guard isHidden == false else {
                loadingAnimatedImage.pause()
                return
            }
            loadingAnimatedImage.play()
        }
    }
    
    // MARK: - Lazy Loads
    private lazy var loadingAnimatedImage: AnimationView = {
        let av = AnimationView(name: "surf-puddle")
        av.contentMode = .scaleAspectFit
        av.loopMode = .loop
        av.play()
        addSubview(av)
        return av
    }()
    private lazy var loadingTitle: ClingstoneLabel = {
        let label = ClingstoneLabel(
            "Loading..",
            type: .body_regular,
            align: .center
        )
        addSubview(label)
        return label
    }()
}
