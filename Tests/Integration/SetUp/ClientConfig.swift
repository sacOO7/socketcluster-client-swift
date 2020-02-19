//
//  File.swift
//  
//
//  Created by Sachin Shinde on 09/02/20.
//

import Foundation

class ClientConfig {

    var host : String!
    var port : Int16!
    
    internal init(host: String?, port: Int16?) {
        self.host = host
        self.port = port
    }
    
    init() {
        self.host = "localhost"
        self.port = 8000
    }
    
    func getUrl() -> String {
        return "http://\(host!):\(port!)/socketcluster/"
    }
}
