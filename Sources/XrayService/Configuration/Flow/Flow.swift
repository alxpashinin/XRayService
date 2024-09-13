//
//  Flow.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

enum Flow: String, Identifiable, CaseIterable, CustomStringConvertible, Codable {
    public var id: Self { self }
    
    case none
    case xtls_rprx_vision = "xtls-rprx-vision"
    case xtls_rprx_vision_udp443 = "xtls-rprx-vision-udp443"
    
    public var description: String {
        switch self {
        case .none:
            return "None"
        case .xtls_rprx_vision:
            return "XTLS-RPRX-Vision"
        case .xtls_rprx_vision_udp443:
            return "XTLS-RPRX-Vision-UDP443"
        }
    }
}
