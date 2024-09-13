//
//  File.swift
//  
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation


public struct VLESS: Codable {
    public struct User: Codable {
        public var id: String = ""
        public var encryption: String = "none"
        var flow = Flow.none
    }

    public var address: String = ""
    public var port: Int = 443
    public var users: [User] = [User()]
}
