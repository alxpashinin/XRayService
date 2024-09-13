//
//  Transport.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

public enum Transport: String, Identifiable, CaseIterable, CustomStringConvertible, Codable {
    public var id: Self { self }
    
    case tcp, kcp, ws, http, quic, grpc

    public var description: String {
        switch self {
        case .tcp:
            return "TCP"
        case .kcp:
            return "mKCP"
        case .ws:
            return "WebSocket"
        case .http:
            return "HTTP/2"
        case .quic:
            return "QUIC"
        case .grpc:
            return "gRPC"
        }
    }
    
    public var streamSettingsKey: String {
        switch self {
        case .tcp:
            return "tcpSettings"
        case .kcp:
            return "kcpSettings"
        case .ws:
            return "wsSettings"
        case .http:
            return "httpSettings"
        case .quic:
            return "quicSettings"
        case .grpc:
            return "grpcSettings"
        }
    }
    
    public func streamSettings(config: Configuration) throws -> Any {
        switch self {
        case .tcp:
            guard let tcp = config.tcp else {
                throw NSError.newError("\(self.description) build failed")
            }
            return [:] // try JSONSerialization.jsonObject(with: try JSONEncoder().encode(tcp))
        case .kcp:
            guard let kcp = config.kcp else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try JSONSerialization.jsonObject(with: JSONEncoder().encode(kcp))
        case .ws:
            guard let ws = config.ws else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try JSONSerialization.jsonObject(with: JSONEncoder().encode(ws))
        case .http:
            guard let http = config.http else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try JSONSerialization.jsonObject(with: JSONEncoder().encode(http))
        case .quic:
            guard let quic = config.quic else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try JSONSerialization.jsonObject(with: JSONEncoder().encode(quic))
        case .grpc:
            guard let grpc = config.grpc else {
                throw NSError.newError("\(self.description) build failed")
            }
            return try JSONSerialization.jsonObject(with: JSONEncoder().encode(grpc))
        }
    }
}
