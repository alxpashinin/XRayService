//
//  Vless.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

struct Vless: Codable {
    public struct User: Codable {
        public var id: String = ""
        public var encryption: String = "none"
        public var flow = Flow.none
    }

    public var address: String = ""
    public var port: Int = 443
    public var users: [User] = [User()]
}
