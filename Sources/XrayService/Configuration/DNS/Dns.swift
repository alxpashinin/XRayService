//
//  File.swift
//
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation

public struct Dns: Codable {
    public let server: String
    public let adress: String
    public let queryStrategy: String
    public let host: String
    public let disableCache: Bool
    public let rule: RouteModel.Rule

    public static let cloudflare = Dns(server: "https://one.one.one.one/dns-query", adress: "1.1.1.1", queryStrategy: "UseIPv4", host: "one.one.one.one", disableCache: true, rule: RouteModel.Rule(ip: ["1.1.1.1"], outboundTag: RouteModel.Outbound.proxy, __enabled__: true))
    public static let google = Dns(server: "https://dns.google/dns-query", adress: "8.8.8.8", queryStrategy: "UseIPv4", host: "dns.google", disableCache: true, rule: RouteModel.Rule(ip: ["8.8.8.8"], outboundTag: RouteModel.Outbound.proxy, __enabled__: true))
    public static let quad9 = Dns(server: "https://dns.quad9.net/dns-query", adress: "9.9.9.9", queryStrategy: "UseIPv4", host: "dns.quad9.net", disableCache: true, rule: RouteModel.Rule(ip: ["9.9.9.9"], outboundTag: RouteModel.Outbound.proxy, __enabled__: true))
}
