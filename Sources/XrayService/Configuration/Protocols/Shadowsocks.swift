//
//  Shadowsocks.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

public struct Shadowsocks: Codable {
    public enum Method: String, Identifiable, CustomStringConvertible, Codable, CaseIterable {
        
        public var id: Self { self }
        
        case _2022_blake3_aes_128_gcm = "2022-blake3-aes-128-gcm"
        case _2022_blake3_aes_256_gcm = "2022-blake3-aes-256-gcm"
        case _2022_blake3_chacha20_poly1305 = "2022-blake3-chacha20-poly1305"
        case aes_256_gcm = "aes-256-gcm"
        case aes_128_gcm = "aes-128-gcm"
        case chacha20_poly1305 = "chacha20-poly1305"
        case chacha20_ietf_poly1305 = "chacha20-ietf-poly1305"
        case plain
        case none
        
        public var description: String {
            switch self {
            case ._2022_blake3_aes_128_gcm:
                return "2022-Blake3-AES-128-GCM"
            case ._2022_blake3_aes_256_gcm:
                return "2022-Blake3-AES-256-GCM"
            case ._2022_blake3_chacha20_poly1305:
                return "2022-Blake3-Chacha20-Poly1305"
            case .aes_256_gcm:
                return "AES-256-GCM"
            case .aes_128_gcm:
                return "AES-128-GCM"
            case .chacha20_poly1305:
                return "Chacha20-Poly1305"
            case .chacha20_ietf_poly1305:
                return "Chacha20-ietf-Poly1305"
            case .none:
                return "None"
            case .plain:
                return "Plain"
            }
        }
    }

    public struct Server: Codable {
        public var address: String = ""
        public var port: Int = 443
        public var password: String = ""
        public var email: String = ""
        public var method = Method.none
        public var uot: Bool = false
        public var level: Int = 0
    }

    public var servers: [Server] = [Server()]
}
