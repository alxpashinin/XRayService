//
//  Attributes.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

struct Attributes: Codable {
    public static let key = "Configuration.Attributes"
    
    public let alias: String
    public let source: URL
    public let leastUpdated: Date
}
