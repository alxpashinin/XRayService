//
//  Fingerprint.swift
//  VmVApp
//
//  Created by Кирилл Перминов on 22.06.2024.
//

import Foundation

enum Fingerprint: String, Identifiable, CaseIterable, CustomStringConvertible, Codable {
    public var id: Self { self }
    
    case chrome
    case firefox
    case safari
    case ios
    case android
    case edge
    case _360 = "360"
    case qq
    case random
    case randomized
    
    public var description: String {
        switch self {
        case .chrome:
            return "Chrome"
        case .firefox:
            return "Firefox"
        case .safari:
            return "Safari"
        case .ios:
            return "iOS"
        case .android:
            return "Android"
        case .edge:
            return "Edge"
        case ._360:
            return "360"
        case .qq:
            return "QQ"
        case .random:
            return "Random"
        case .randomized:
            return "Randomized"
        }
    }
}
