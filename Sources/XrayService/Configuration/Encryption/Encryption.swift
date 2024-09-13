//
//  Encryption.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

enum Encryption: String, Identifiable, CustomStringConvertible, Codable {
    public var id: Self { self }
    
    case aes_128_gcm = "aes-128-gcm"
    case chacha20_poly1305 = "chacha20-poly1305"
    case auto
    case none
    case zero
    
    public var description: String {
        switch self {
        case .aes_128_gcm:
            return "AES-128-GCM"
        case .chacha20_poly1305:
            return "Chacha20-Poly1305"
        case .auto:
            return "Auto"
        case .none:
            return "None"
        case .zero:
            return "Zero"
        }
    }
            
    public static let vmess: [Encryption] = [.chacha20_poly1305, .aes_128_gcm, .auto, .none, .zero]
    public static let quic: [Encryption] = [.chacha20_poly1305, .aes_128_gcm, .none]
}
