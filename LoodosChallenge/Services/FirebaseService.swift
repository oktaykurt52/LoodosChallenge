//
//  FirebaseService.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import Firebase
import FirebaseRemoteConfig

enum FirebaseServiceError: Error {
    case NoConnection
    case RemoteConfigFailed(message: String)
}

protocol RemoteConfigProtocol: AnyObject {
    func fetchConfig() async throws
}

class RemoteConfigService: RemoteConfigProtocol {
    
    func fetchConfig() async throws {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        do {
            try await remoteConfig.fetch()
            try await remoteConfig.activate()
            let splashText = remoteConfig["splashText"].stringValue
            currentSplashText = splashText
        } catch let error {
            throw FirebaseServiceError.RemoteConfigFailed(message: error.localizedDescription)
        }
    }
}

class FirebaseService {
    
    var remoteConfigService: RemoteConfigService?
    
    init(remoteConfigService: RemoteConfigService? = nil) {
        self.remoteConfigService = remoteConfigService
    }
}
