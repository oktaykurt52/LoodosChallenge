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
protocol AnalyticsProtocol: AnyObject {
    func logEvent(with eventName: String, optionalParameters: [String: Any]?)
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

class AnalyticsService: AnalyticsProtocol {
    
    func logEvent(with eventName: String, optionalParameters: [String: Any]?) {
        Analytics.logEvent(eventName, parameters: optionalParameters)
    }
}

class FirebaseService {
    
    var remoteConfigService: RemoteConfigService?
    var analyticsService: AnalyticsService?
    
    init(remoteConfigService: RemoteConfigService? = nil, analyticsService: AnalyticsService? = nil) {
        self.remoteConfigService = remoteConfigService
        self.analyticsService = analyticsService
    }
}
