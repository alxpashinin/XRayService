// The Swift Programming Language
// https://docs.swift.org/swift-book

import XRayCoreIOSWrapper

public protocol XrayService {
    var xrayLogger: XRayLoggerProtocol { get }
    
    func startXray(with configuration: Data, asstesDirectoryPath path: String) throws
    
    func startXray(with configuration: Data) throws
    
    func startSocks5Tunnel(serverPort port: Int, tunnelPath: URL) throws
    
    func startSocks5Tunnel(serverPort port: Int, content: String) throws
    
    func setAssetsDirectory(directory: String) 
    
    func measureOutboundDelay(config: Data, url: String?) throws -> Int64
    
    func stop()
}
