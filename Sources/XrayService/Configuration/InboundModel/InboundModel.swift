//
//  File.swift
//
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation

public struct InboundModel: Codable {
    public var inbounds: [InboundSetting] = []

    public struct InboundSetting: Codable {
        public var listen: String
        public var port: Int
        public var protocolType: String
        public var settings: [SettingsModel]

        enum CodingKeys: String, CodingKey {
            case protocolType = "protocol"
            case listen, port, settings
        }
    }

    public struct SettingsModel: Codable {
        public var adress: String? = nil
        public var port: Int? = nil
        public var network: String? = nil
        public var udp: Bool? = nil

        enum CodingKeys: String, CodingKey {
            case adress, port, network, udp
        }
    }
}
