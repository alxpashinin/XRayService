//
//  HeaderType.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

enum HeaderType: String, Identifiable, CaseIterable, CustomStringConvertible, Codable {
    public var id: Self { self }
    
    case none
    case srtp
    case utp
    case wechat_video = "wechat-video"
    case dtls
    case wireguard
        
    public var description: String {
        switch self {
        case .none:
            return "None"
        case .srtp:
            return "SRTP"
        case .utp:
            return "UTP"
        case .wechat_video:
            return "Wecaht Video"
        case .dtls:
            return "DTLS"
        case .wireguard:
            return "Wireguard"
        }
    }
}
