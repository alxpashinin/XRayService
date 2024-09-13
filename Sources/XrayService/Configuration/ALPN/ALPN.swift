//
//  ALPN.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

enum ALPN: String, Identifiable, CaseIterable, CustomStringConvertible, Codable {
    public var id: Self { self }
    
    case h2
    case http1_1 = "http/1.1"
    
    public var description: String {
        switch self {
        case .h2:
            return "H2"
        case .http1_1:
            return "HTTP/1.1"
        }
    }
}
