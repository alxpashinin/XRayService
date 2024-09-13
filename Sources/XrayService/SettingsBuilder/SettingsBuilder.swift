//
//  File.swift
//
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation

@available(iOS 13.0.0, *)
public struct SettingsBuilder {
    let configuration: Configuration
    
    func buildConfigurationData() async throws -> Data {
        var configuration: [String: Any] = [:]
        configuration["inbounds"] = try self.buildInbound()
        var route = RouteModel.default
        configuration["routing"] = try await route.build(userRules: self.configuration.userRules, dnsRule: self.configuration.dns.rule)
        
        configuration["outbounds"] = try [
            self.buildProxyOutbound(),
            self.buildDirectOutbound(),
            self.buildBlockOutbound(),
            self.buildDNSOutbound()
        ]
        
        configuration["log"] = self.buildLogs()
        configuration["policy"] = try self.buildPolicy()
        configuration["dns"] = try self.buildDNS()
        
        try NSLog(String(data: JSONSerialization.data(withJSONObject: await route.build(userRules: self.configuration.userRules, dnsRule: self.configuration.dns.rule), options: .sortedKeys), encoding: .utf8) ?? "---")
        
        return try JSONSerialization.data(withJSONObject: configuration, options: .prettyPrinted)
    }
    
    private func buildDNS() throws -> Any {
        try JSONSerialization.jsonObject(with: JSONEncoder().encode(self.configuration.dns))
    }
    
    private func buildPolicy() throws -> Any {
        try JSONSerialization.jsonObject(with: JSONEncoder().encode(self.configuration.systemModel))
    }
    
    private func buildLogs() -> Any {
        let log = {
            if self.configuration.currentLogModel.onlyAppLogsEnabled {
                return VmVLogModel.default
            }
            return self.configuration.currentLogModel
        }()
        
        var logSettings: [String: Any] = [:]
        
        logSettings["loglevel"] = log.errorLogSeverity.description
        logSettings["dnsLog"] = log.dnsLogEnabled
        
        return logSettings
    }
    
    private func buildInbound() throws -> Any {
        // TODO: public let inboundModel: InboundModel in Configuration give InboundModel, need to turn InboundModel to [String: Any] inbound and inbound2
        var inbound: [String: Any] = [:]
        inbound["listen"] = "[::1]"
        inbound["port"] = 10808
        inbound["protocol"] = "socks"
        inbound["settings"] = [
            "udp": true
        ]
        inbound["sniffing"] = try self.configuration.currentSniffingModel.build()
        
        var inbound2: [String: Any] = [:]
        
        inbound2["listen"] = "[::1]"
        inbound2["port"] = 10853
        inbound2["protocol"] = "dokodemo-door"
        inbound2["settings"] = [
            "address": self.configuration.dns.adress,
            "port": 53,
            "network": "udp"
        ]
        inbound2["tag"] = "dns-in"
        
        return [inbound, inbound2]
    }
    
    private func buildProxyOutbound() throws -> Any {
        var proxy: [String: Any] = [:]
        proxy["tag"] = "proxy"
        proxy["protocol"] = self.configuration.protocolType.rawValue
        proxy["settings"] = try self.configuration.protocolType.proxySettings(config: self.configuration)
        var streamSettings: [String: Any] = [:]
        streamSettings["network"] = self.configuration.network.rawValue
        streamSettings[self.configuration.network.streamSettingsKey] = try self.configuration.network.streamSettings(config: self.configuration)
        streamSettings["security"] = self.configuration.security.rawValue
        if self.configuration.security != .none {
            streamSettings[self.configuration.security.streamSettingsKey!] = try self.configuration.security.streamSettings(config: self.configuration)
        }
        proxy["streamSettings"] = streamSettings
        
        return proxy
    }
    
    private func buildDirectOutbound() throws -> Any {
        try JSONSerialization.jsonObject(with: JSONEncoder().encode(self.configuration.directOutbound))
    }
    
    private func buildBlockOutbound() throws -> Any {
        try JSONSerialization.jsonObject(with: JSONEncoder().encode(self.configuration.blockOutbound))
    }
    
    private func buildDNSOutbound() throws -> Any {
        try JSONSerialization.jsonObject(with: JSONEncoder().encode(self.configuration.dnsOutbound))
    }
}

@available(iOS 13.0.0, *)
extension RouteModel {
    mutating func build(userRules: [RouteModel.Rule], dnsRule: RouteModel.Rule) async throws -> Any {
        if !userRules.isEmpty {
            self.rules = userRules
        }
        self.rules.append(Rule(inboundTag: ["dns-in"], outboundTag: RouteModel.Outbound.dnsOut, __enabled__: true))
        self.rules.append(Rule(port: "853", network: "tcp", outboundTag: RouteModel.Outbound.block, __enabled__: true))
        self.rules.append(Rule(port: "443,853", network: "udp", outboundTag: RouteModel.Outbound.block, __enabled__: true))
        self.rules.append(Rule(domain: ["apvl.vmeanvmean.org"], outboundTag: RouteModel.Outbound.direct, __enabled__: true))
        self.rules.append(dnsRule)
        
        return try JSONSerialization.jsonObject(with: JSONEncoder().encode(self))
    }
    
    func directDomains() -> [String] {
        return self.rules.filter(\.__enabled__).filter { rule in
            rule.outboundTag == .direct
        }.compactMap { directRules in
            directRules.domain
        }.flatMap { $0 }
    }
}

extension VmVSniffingModel {
    func build() throws -> Any {
        var sniffing: [String: Any] = [:]
        sniffing["enabled"] = self.enabled
        sniffing["routeOnly"] = self.routeOnly
        sniffing["destOverride"] = self.destOverride
        return sniffing
    }
}
