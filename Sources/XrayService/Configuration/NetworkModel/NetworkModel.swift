//
//  File.swift
//
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation

public struct VmVNetworkModel: Codable, Equatable {
    public let hideVPNIcon: Bool
    public let ipv6Enabled: Bool
    public let inboundPort: Int

    public static let `default` = VmVNetworkModel(
        hideVPNIcon: false,
        ipv6Enabled: false,
        inboundPort: 53308
    )
}
