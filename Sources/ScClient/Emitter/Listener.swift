//
//  Listener.swift
//  ScClientPackageDescription
//
//  Created by admin on 13/01/2018.
//

import Foundation
public class Listener {
    var emitAckListener : [Int : (String, (String, Any, Any ) -> Void )]
    var onListener :[String : (String, Any) -> Void]
    var onAckListener : [String: (String, Any, (Any, Any) -> Void ) -> Void]

    public init() {
        emitAckListener = [Int : (String, (String, Any, Any ) -> Void )]()
        onListener = [String : (String, Any) -> Void]()
        onAckListener = [String: (String, Any, (Any, Any) -> Void ) -> Void]()
    }

    func putEmitAck(id : Int, eventName : String, ack : @escaping (String, Any, Any ) -> Void ) {
        self.emitAckListener[id] = (eventName, ack)
    }
    
    
    func handleEmitAck (id : Int, error : Any, data : Any) {
        if let ackobject = emitAckListener[id] {
            let eventName = ackobject.0
            let ack = ackobject.1
            ack(eventName, error, data)
        }
    }
    
    func putOnListener(eventName : String, onListener: @escaping (String, Any) -> Void) {
        self.onListener[eventName] = onListener
    }
    
    func handleOnListener (eventName : String, data : Any) {
        if let on = onListener[eventName] {
            on(eventName, data)
        }
    }
    
    func putOnAckListener(eventName : String, onAckListener : @escaping (String, Any, (Any, Any) -> Void ) -> Void) {
        self.onAckListener[eventName] = onAckListener
    }
    
    func handleOnAckListener (eventName : String, data : Any, ack : (Any, Any) -> Void) {
        if let onAck = onAckListener[eventName] {
            onAck(eventName, data, ack)
        }
    }
    
    func hasEventAck(eventName : String) -> Bool {
        return (onAckListener[eventName] != nil)
    }

}
