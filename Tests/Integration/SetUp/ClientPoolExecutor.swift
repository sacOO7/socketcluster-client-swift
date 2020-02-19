//
//  File.swift
//  
//
//  Created by Sachin Shinde on 11/02/20.
//

import Foundation
import ScClient
import RxSwift

class ClientPoolExecutor {
    
    var noOfClients = 1
    var clientConfig: ClientConfig
    var queue = DispatchQueue(label: "com.clientPoolExecutor", qos: .default)
    
    init(noOfClients: Int32, clientConfig: ClientConfig, queue: DispatchQueue) {
        self.noOfClients = Int(noOfClients)
        self.clientConfig = clientConfig
        self.queue = queue
    }
    
    init(clientConfig: ClientConfig, queue: DispatchQueue) {
        self.clientConfig = clientConfig
        self.queue = queue
    }
    
    init(clientConfig: ClientConfig) {
        self.clientConfig = clientConfig
    }
    
    func ready() -> ReplaySubject<ScClient> {
        let pool: ClientPool = ClientPool.create(name: "client 1", clientConfig: self.clientConfig)
        for i in 2...self.noOfClients {
            let clientName = "client \(i)"
            pool.add(name: clientName, clientConfig: self.clientConfig)
        }
        let clientPublisher: ReplaySubject = ReplaySubject<ScClient>.create(bufferSize: self.noOfClients)
        let clients : [String : ScClient] = pool.build()
        for client in clients.values {
            client.setAuthenticationListener(onSetAuthentication: nil, onAuthentication: {
                (client :ScClient, isAuthenticated : Bool?) in
                    clientPublisher.onNext(client)
                })
            client.setBasicListener(onConnect: nil, onConnectError: { (client: ScClient, error: Error?) in
                clientPublisher.onError(error!)
            }, onDisconnect: nil)
            queue.async {
                client.setBackgroundQueue(queueName: "com.backgroundQueue")
                client.connect()
            }
        }
        return clientPublisher
    }
}
