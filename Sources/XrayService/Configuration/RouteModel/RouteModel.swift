//
//  File.swift
//  
//
//  Created by Кирилл Перминов on 28.06.2024.
//

import Foundation


public struct RouteModel: Codable, Equatable {
    public enum DomainStrategy: String, Identifiable, CaseIterable, CustomStringConvertible, Codable {
        public var id: Self { self }
        case asIs = "AsIs"
        case ipIfNonMatch = "IPIfNonMatch"
        case ipOnDemand = "IPOnDemand"
        public var description: String {
            return rawValue
        }
    }
    
    public enum DomainMatcher: String, Identifiable, CaseIterable, CustomStringConvertible, Codable {
        public var id: Self { self }
        case hybrid, linear
        public var description: String {
            switch self {
            case .hybrid:
                return "Hybrid"
            case .linear:
                return "Linear"
            }
        }
    }
    
    public enum Outbound: String, Identifiable, CaseIterable, CustomStringConvertible, Codable {
        public var id: Self { self }
        case direct, proxy, block, reject
        case dnsOut = "dns-out"
        public var description: String {
            switch self {
            case .direct:
                return "Direct"
            case .proxy:
                return "Proxy"
            case .block:
                return "Block"
            case .reject:
                return "Reject"
            case .dnsOut:
                return "Dns-Out"
            }
        }
    }
    
    public struct Rule: Codable, Equatable, Identifiable {
        public var id: UUID { __id__ }
        
        /// The domain matching algorithm. The option here takes priority over the domainMatcher configured in RoutingObject
        ///
        ///     DomainMatcher.hybrid
        /// Uses a new domain matching algorithm that is faster and takes up less space. This is the default value
        ///
        ///     DomainMatcher.linear
        /// Uses the original domain matching algorithm
        public var domainMatcher: DomainMatcher = .hybrid
        
        /// Currently, only the option "field" is supported
        public var type: String = "field"
        
        /// An array where each item is a domain match. There are several forms:
        ///
        /// **Plain string**: If this string matches any part of the target domain, the rule takes effect. For example, "sina.com" can match "sina.com", "sina.com.cn", and "www.sina.com", but not "sina.cn"
        ///
        /// **Regular expression**: Starts with "regexp:" followed by a regular expression. When this regular expression matches the target domain, the rule takes effect. For example, "regexp:\\.goo.*\\.comquot; matches "www.google.com" or "fonts.googleapis.com", but not "google.com".
        ///
        /// **Subdomain (recommended)**: Starts with "domain:" followed by a domain. When this domain is the target domain or a subdomain of the target domain, the rule takes effect. For example, "domain:xray.com" matches "www.xray.com" and "xray.com", but not "wxray.com".
        ///
        /// **Exact match**: Starts with "full:" followed by a domain. When this domain is an exact match for the target domain, the rule takes effect. For example, "full:xray.com" matches "xray.com" but not "www.xray.com".
        ///
        /// **Predefined domain lis**t: Starts with "geosite:" followed by a name such as geosite:google or geosite:cn. The names and domain lists are listed in https://xtls.github.io/en/config/routing.html#predefined-domain-list
        ///
        /// **Load domains from a file**: Formatted as "ext:file:tag", where the file is stored in the resource directory and has the same format as geosite.dat. The tag must exist in the file.
        public var domain: [String]?
        
        /// An array where each item represents an IP range. This rule will take effect when the target IP matches any of the IP ranges in the array. There are several types of IP ranges:
        ///
        /// **IP**: In the format of "127.0.0.1"
        ///
        /// **CIDR**:  In the format of "10.0.0.0/8"
        ///
        /// **Predefined IP lists**: These lists are included in every Xray installation package under the file name geoip.dat. They can be used in the format of "geoip:cn", where cn is a two-letter country code. The prefix geoip:(all lowercase) must be used, and nearly all countries that have internet access are supported.
        ///
        /// **Loading IP from a file**: n the format of "ext:file:tag", where file is the file name and tag is a label that must exist in the file. The prefix ext: (all lowercase) must be used, and the file should be located in the resource directory with the same format as geoip.dat
        public var ip: [String]?
        
        /// The target port range, which can take on three forms
        ///
        /// **a-b**: a and b are both positive integers less than 65536. This range is a closed interval, and this rule will take effect when the source port falls within this range
        ///
        /// **a: a**: is a positive integer less than 65536. This rule will take effect when the source port is a
        ///
        /// A mixture of the above two forms, separated by commas ",". For example: "53,443,1000-2000"
        public var port: String?
        
        /// The source port, which can take on three forms:
        ///
        /// **a-b**: a and b are both positive integers less than 65536. This range is a closed interval, and this rule will take effect when the source port falls within this range
        ///
        /// **a: a**: is a positive integer less than 65536. This rule will take effect when the source port is a
        ///
        /// A mixture of the above two forms, separated by commas ",". For example: "53,443,1000-2000"
        public var sourcePort: String?
        
        /// This can be "tcp", "udp", or "tcp,udp". This rule will take effect when the connection method is the specified one.
        public var network: String?
        
        /// An array where each item represents an IP range in the format of IP, CIDR, GeoIP, or loading IP from a file. This rule will take effect when the source IP matches any of the IP ranges in the array.
        public var source: [String]?
        
        /// An array where each item represents an email address. This rule will take effect when the source user matches any of the email addresses in the array.
        public var user: [String]?
        
        /// An array where each item represents an identifier. This rule will take effect when the inbound protocol matches any of the identifiers in the array.
        public var inboundTag: [String]?
        
        /// An array where each item represents a protocol. This rule will take effect when the protocol of the current connection matches any of the protocols in the array.
        public var `protocol`: [String]?
        
        /// A json object with string keys and values, used to detect the HTTP headers of the traffic. It matches when all specified keys exist in the header and corresponding values are a substring of the header value. The key is case in-sensitive. You can use regex to match with value.
        ///
        /// Examples:
        ///
        /// Detect HTTP GET：{":method": "GET"}
        ///
        /// Detect HTTP Path：{":path": "/test"}"
        ///
        /// Detect Content Type：{"accept": "text/html"}"
        public var attrs: String?
        
        /// Corresponds to the identifier of an outbound.
        public var outboundTag: Outbound = .direct
        public var balancerTag: String?
        
        public var __id__: UUID = .init()
        public var __name__: String = ""
        public var __enabled__: Bool = false
        
        public var __defaultName__: String {
            "Rule_\(__id__.uuidString)"
        }
    }
    
    public struct Balancer: Codable, Equatable {
        var tag: String
        var selector: [String] = []
    }
    
    public var domainStrategy: DomainStrategy = .asIs
    public var domainMatcher: DomainMatcher = .hybrid
    public var rules: [Rule] = []
    public var balancers: [Balancer] = []
   
    public static let `default` = RouteModel()
    
    public var isDefault: Bool {
        rules.isEmpty && domainStrategy == .asIs && domainMatcher == .hybrid && balancers.isEmpty
    }
    
}

extension [RouteModel.Rule] {
    func isSame(_ other: [RouteModel.Rule]) -> Bool {
        if self.count != other.count { return false }
        for rule in 0 ... self.count - 1 {
            if self[rule].__enabled__ != other[rule].__enabled__ { return false }
            if self[rule].domain != other[rule].domain { return false }
            if self[rule].type != other[rule].type { return false }
            if self[rule].ip != other[rule].ip { return false }
            if self[rule].port != other[rule].port { return false }
            if self[rule].sourcePort != other[rule].sourcePort { return false }
            if self[rule].source != other[rule].source { return false }
            if self[rule].user != other[rule].user { return false }
            if self[rule].inboundTag != other[rule].inboundTag { return false }
            if self[rule].protocol != other[rule].protocol { return false }
            if self[rule].attrs != other[rule].attrs { return false }
            if self[rule].outboundTag != other[rule].outboundTag { return false }
            if self[rule].balancerTag != other[rule].balancerTag { return false }
            if self[rule].__name__ != other[rule].__name__ { return false }
        }
        return true
    }
}


