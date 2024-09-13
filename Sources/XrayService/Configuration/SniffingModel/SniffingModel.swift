//
//  File.swift
//  
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation


public struct VmVSniffingModel: Codable, Equatable {
    public let enabled: Bool
    public let destOverride: [String]
    public let metadataOnly: Bool
    public let routeOnly: Bool
    public let excludedDomains: [String]
    
    public static let `default` = VmVSniffingModel(
        enabled: true,
        destOverride: ["http", "tls", "quic"],
        metadataOnly: false,
        routeOnly: true,
        excludedDomains: ["courier.push.apple.com"]
    )
}
