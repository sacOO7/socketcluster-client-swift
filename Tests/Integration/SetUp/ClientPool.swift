//
//  File.swift
//  
//
//  Created by Sachin Shinde on 11/02/20.
//

import Foundation
@testable import ScClient

class ClientPool {
    
    var clients : [String : ScClient]
    
    init() {
        clients = [String : ScClient]()
    }
    
    public static func create(name: String, clientConfig: ClientConfig) -> ClientPool {
        let clientPool = ClientPool()
        return clientPool.add(name: name, clientConfig: clientConfig)
    }
    
    public func add(name: String, clientConfig: ClientConfig) -> ClientPool {
        let scclient = ScClientBuilder.build(clientConfig: clientConfig)
        clients[name] = scclient
        return self
    }
    
    public func build() -> [String : ScClient] {
        return self.clients
    }
}
