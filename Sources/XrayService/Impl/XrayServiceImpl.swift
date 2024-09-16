//
//  File.swift
//
//
//  Created by Кирилл Перминов on 21.06.2024.
//
import Foundation
import XRayCoreIOSWrapper
import Tun2SocksKit
 
public struct XrayServiceImpl: XrayService {
    public let xrayLogger: XRayLoggerProtocol = XRayLogger()
    
    public init(){}
    
    public func startXray(with configuration: Data, asstesDirectoryPath path: String) throws {
        XRaySetAssetsDirectory(path)
        try startXray(with: configuration)
    }
    
    public func startXray(with configuration: Data) throws {
        var error: NSError? = nil
        XRayStartXray(configuration, xrayLogger, &error)
        
        try error.flatMap {
            throw $0
        }
    }
    
    public func setAssetsDirectory(directory: String){
        XRaySetAssetsDirectory(directory)
    }
    
    public func measureOutboundDelay(config: Data, url: String? = nil) throws -> Int64{
        var result: Int64 = -1
        var error: NSError? = nil
        let _ = XRayMeasureOutboundDelay(config, url, &result, &error)
        try error.flatMap {
            throw $0
        }
        return result
    }
    
    public func startSocks5Tunnel(serverPort port: Int, tunnelPath: URL) throws {
        Socks5Tunnel.run(withConfig: .file(path: tunnelPath)) { _ in
        }
    }
    
    public func startSocks5Tunnel(serverPort port: Int, content: String) throws {
        Socks5Tunnel.run(withConfig: .string(content: content)) { _ in
        }
    }
    
    public func stop() {
        XRayStopXray()
        Socks5Tunnel.quit()
    }
}
