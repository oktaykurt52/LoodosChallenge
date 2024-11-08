//
//  SplashViewModel.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit
import SnapKit

class SplashViewModel {
    
    lazy var splashTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var splashSubtitle: UILabel = {
        let label = UILabel()
        label.createTitle(customizableText: .init(text: "Unlimited Entertainment", textColor: .init(color: .splashTitle), fontFamily: .SFPro, fontWeight: .Regular, fontSize: 14))
        return label
    }()
    
    lazy var splashTextStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            splashTitle, splashSubtitle
        ])
        stackView.alpha = 0
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var loadingIcon: LoadingIcon = {
        let imageView = LoadingIcon(image: .splashLoadingIcon)
        return imageView
    }()
    
    var networkStatus: NetworkStatus = .unknown {
        didSet {
            guard oldValue != networkStatus else { return } // NWPathMonitor pushes changes multiple times!
            switch self.networkStatus {
            case .connected:
                self.splashView?.dismissAlert()
                self.loadingIcon.startLoading()
                let service = FirebaseService(remoteConfigService: .init())
                Task { @MainActor in
                    try await service.remoteConfigService?.fetchConfig()
                    self.splashTitle.createTitle(customizableText: .init(text: currentSplashText, textColor: .init(color: .splashTitle), fontFamily: .DrukWide, fontWeight: .Bold, fontSize: 52, kern: -0.5))
                    self.splashTextStack.changeVisibility(alpha: 1.0, animated: true)
                    try await Task.sleep(nanoseconds: 3_000_000_000) // Sleep for 3 seconds
                    self.loadingIcon.stopLoading()
                    self.splashView?.pushHome()
                }
            case .disconnected:
                self.networkStatus = .unknown
                self.splashView?.showAlert(title: "Currently offline", message: "Tap to try again", actionTitle: "Try again", completion: { type in
                    switch type {
                    case .tryAgain:
                        networkMonitor.stopListening()
                        networkMonitor.startListening()
                    }
                })
            default:
                break
            }
        }
    }
    
    weak var splashView: SplashViewController? // Weak ref for splash
    
    func setupRoot(on viewController: SplashViewController) {
        splashView = viewController
        viewController.view.backgroundColor = .init(color: .background)
        viewController.view.addSubview(splashTextStack)
        viewController.view.addSubview(loadingIcon)
        //...
        splashTextStack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        loadingIcon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(48)
        }
        networkMonitor.connectionStatus = { [weak self] status in
            guard let self = self else { return } // Weak self referance for retain cycle (ARC)
            self.networkStatus = status
        }
        networkMonitor.startListening()
    }
    
    func onDidDisappearTasks() {
        networkMonitor.stopListening()
        networkMonitor.connectionStatus = nil
        splashView?.deinitSelf()
    }
}
