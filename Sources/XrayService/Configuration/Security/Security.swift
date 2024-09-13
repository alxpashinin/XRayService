//
//  Security.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

public enum Security: String, Identifiable, CaseIterable, CustomStringConvertible, Codable {
    public var id: Self { self }
    
    case none, tls, reality
    
    public var description: String {
        switch self {
        case .none:
            return "None"
        case .tls:
            return "TLS"
        case .reality:
            return "Reality"
        }
    }
    
    public var streamSettingsKey: String? {
        switch self {
        case .none:
            return nil
        case .tls:
            return "tlsSettings"
        case .reality:
            return "realitySettings"
        }
    }
    
    public func streamSettings(config: Configuration) throws -> Any? {
        switch self {
        case .none:
            return nil
        case .tls:
            guard let tls = config.tls else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try JSONSerialization.jsonObject(with: JSONEncoder().encode(tls))
        case .reality:
            guard let reality = config.reality else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try JSONSerialization.jsonObject(with: JSONEncoder().encode(reality))
        }
    }
}
