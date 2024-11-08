//
//  NetworkMonitor.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import Foundation
import Network

enum NetworkStatus: String {
    case connected = "User connected to network!"
    case disconnected = "User disconnected from network!"
    case unknown = "User network status is unknown!"
}

class NetworkMonitor {
    
    static let shared = NetworkMonitor() // Global singleton class for possible listening through to app
    
    var connectionStatus: ((_ status: NetworkStatus) -> ())?
    
    private let queue = DispatchQueue(label: "network.monitor", qos: .background)
    var monitor: NWPathMonitor?
    
    func startListening() {
        monitor = NWPathMonitor()
        guard let monitor = self.monitor else { return }
        monitor.pathUpdateHandler = { path in
            guard path.status == .satisfied else {
                self.connectionStatus?(.disconnected)
                return
            }
            
            self.connectionStatus?(.connected)
        }
        monitor.start(queue: queue)
    }
    
    func stopListening() {
        monitor?.cancel()
        monitor = nil
    }
}
