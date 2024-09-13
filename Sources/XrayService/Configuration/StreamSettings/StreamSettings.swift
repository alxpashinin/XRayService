//
//  StreamSettings.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

public struct StreamSettings: Codable {
    
    public struct TLS: Codable {
        public var serverName: String = ""
        public var allowInsecure: Bool = false
        var alpn: [ALPN] = ALPN.allCases
        var fingerprint: Fingerprint = .chrome
    }

    public struct Reality: Codable {
        public var show: Bool = false
        var fingerprint: Fingerprint = .chrome
        public var serverName: String = ""
        public var publicKey: String = ""
        public var shortId: String = ""
        public var spiderX: String = ""
    }

    public struct TCP: Codable {
        public struct Header: Codable {
            var type: HeaderType = .none
        }

        public var header = Header()
    }

    public struct KCP: Codable {
        public struct Header: Codable {
            var type: HeaderType = .none
        }

        public var mtu: Int = 1350
        public var tti: Int = 20
        public var uplinkCapacity: Int = 5
        public var downlinkCapacity: Int = 20
        public var congestion: Bool = false
        public var readBufferSize: Int = 1
        public var writeBufferSize: Int = 1
        public var header = Header()
        public var seed: String = ""
    }

    public struct WS: Codable {
        public var path: String = "/"
        public var headers: [String: String] = [:]
    }

    public struct HTTP: Codable {
        public var host: [String] = []
        public var path: String = "/"
    }

    public struct QUIC: Codable {
        public struct Header: Codable {
            var type: HeaderType = .none
        }

        var security = Encryption.none
        public var key: String = ""
        public var header = Header()
    }

    public struct GRPC: Codable {
        public var serviceName: String = ""
        public var multiMode: Bool = false
    }
}
