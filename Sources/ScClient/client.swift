import Starscream
import Foundation


public class ScClient : WebSocketDelegate {
    
    var authToken : String?
    var socket : WebSocket
    var counter : AtomicInteger?
    
    public func websocketDidConnect(socket: WebSocket) {
        print("websocket is connected")
        socket.write(string: "{\"event\":\"#handshake\",\"data\":{\"authToken\":null},\"cid\":1}")
    }

    public func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
            print("websocket disconnected")
        }
    }

    public func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("got some text: \(text)")
        if (text == "#1") {
            socket.write(string: "#2")
        }
    }

    public func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("Received data: \(data.count)")
    }
    
    public init(url : String) {
        counter = AtomicInteger()
        authToken = nil
        socket = WebSocket(url: URL(string: url)!)
        socket.delegate = self
    }
    
    public func connect() {
        socket.connect()
    }
    
}



