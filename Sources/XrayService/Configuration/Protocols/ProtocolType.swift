//
//  ProtocolType.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

public enum ProtocolType: String, Identifiable, CaseIterable, CustomStringConvertible, Codable {
    public var id: Self { self }
    
    case vless, vmess, trojan, shadowsocks
    
    public var description: String {
        switch self {
        case .vless:
            return "VLESS"
        case .vmess:
            return "VMess"
        case .trojan:
            return "Trojan"
        case .shadowsocks:
            return "Shadowsocks"
        }
    }
    
    public func proxySettings(config: Configuration) throws -> Any {
        switch self {
        case .vless:
            guard let vless = config.vless else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try ["vnext": [JSONSerialization.jsonObject(with: JSONEncoder().encode(vless))]]
        case .vmess:
            guard let vmess = config.vmess else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try ["vnext": [JSONSerialization.jsonObject(with: JSONEncoder().encode(vmess))]]
        case .trojan:
            guard let trojan = config.trojan else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try ["servers": [JSONSerialization.jsonObject(with: JSONEncoder().encode(trojan))]]
        case .shadowsocks:
            guard let shadowsocks = config.shadowsocks else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try ["servers": [JSONSerialization.jsonObject(with: JSONEncoder().encode(shadowsocks))]]
        }
    }
}
