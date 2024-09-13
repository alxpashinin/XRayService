//
//  Trojan.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

public struct Trojan: Codable {
    public struct Server: Codable {
        public var address: String = ""
        public var port: Int = 443
        public var password: String = ""
        public var email: String = ""
    }

    public var servers: [Server] = [Server()]
}
