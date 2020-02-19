//
//  File.swift
//  
//
//  Created by Sachin Shinde on 09/02/20.
//

import XCTest
@testable import ScClient

class ScClientBuilder {
    
    public static func build(clientConfig: ClientConfig) -> ScClient {
        return ScClient(url: clientConfig.getUrl())
    }
}
