//
//  File.swift
//  
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation

public struct SystemModel: Codable {
    public let statsInboundDownlink: Bool
    public let statsInboundUplink: Bool
    public let statsOutboundDownlink: Bool
    public let statsOutboundUplink: Bool
    
}
