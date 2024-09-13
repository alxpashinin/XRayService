//
//  Configuration.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation
open class Configuration: Codable {
    
    public var dns: Dns
    public let userRules: [RouteModel.Rule]
    public let currentLogModel: VmVLogModel
    public let currentSniffingModel: VmVSniffingModel
    public let systemModel: SystemModel
    public let inboundModel: InboundModel
    public var directOutbound: DirectOutbound
    public var blockOutbound: BlockOutbound
    public var dnsOutbound: DNSOutbound
    
    public var protocolType: ProtocolType
    public var discription: String
    public var originalSource: String
    public var vless: VLESS?
    public var vmess: VMess?
    public var trojan: Trojan?
    public var shadowsocks: Shadowsocks?
    
    public var network: Transport
    public var tcp: StreamSettings.TCP? = nil
    public var kcp: StreamSettings.KCP? = nil
    public var ws: StreamSettings.WS? = nil
    public var http: StreamSettings.HTTP? = nil
    public var quic: StreamSettings.QUIC? = nil
    public var grpc: StreamSettings.GRPC? = nil
    
    public var security: Security
    public var tls: StreamSettings.TLS? = nil
    public var reality: StreamSettings.Reality? = nil
    
    
}


public extension NSError {
    static func newError(_ message: String) -> NSError {
        NSError(domain: "ttcservice.vmv-app", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
