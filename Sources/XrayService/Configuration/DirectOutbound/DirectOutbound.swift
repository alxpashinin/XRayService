//
//  File.swift
//
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation

public struct DirectOutbound: Codable {
    public let `protocol`: String
    public let settings: Settings
    public let tag: String

    public struct Settings: Codable {
        public let domainStrategy: String
    }
}
