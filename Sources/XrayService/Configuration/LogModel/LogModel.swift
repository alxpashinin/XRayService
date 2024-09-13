//
//  File.swift
//  
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation


public struct VmVLogModel: Codable, Equatable {
    public enum Severity: Int, Codable, Equatable, CaseIterable, Identifiable, CustomStringConvertible {
        public var description: String {
            switch self {
                case .none:
                    "none"
                case .error:
                    "error"
                case .warning:
                    "warning"
                case .info:
                    "info"
                case .debug:
                    "debug"
            }
        }
        
        public var id: Self { self }
        case none = 0
        case error = 1
        case warning = 2
        case info = 3
        case debug = 4
    }
    
    public var accessLogEnabled: Bool
    public var dnsLogEnabled: Bool
    public var onlyAppLogsEnabled: Bool
    public var errorLogSeverity: Severity
    
    public static let `default` = VmVLogModel(
        accessLogEnabled: false,
        dnsLogEnabled: false,
        onlyAppLogsEnabled: false,
        errorLogSeverity: .none
    )
}
