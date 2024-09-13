//
//  VMess.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

public struct VMess: Codable {
    
    public struct User: Codable {
        public var id: String = ""
        public var alterId: Int = 0
        var security = Encryption.auto
    }

    public var address: String = ""
    public var port: Int = 443
    public var users: [User] = [User()]
}
