//
//  File.swift
//  
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation

public struct DNSOutbound: Codable {
    public let `protocol`: String
    public let settings: Settings
    public let tag: String

    public struct Settings: Codable {
        public let nonIPQuery: String
    }
    
    public struct ProxySettings: Codable {
        public let tag: String
    }
}
