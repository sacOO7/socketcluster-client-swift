import Starscream
import Foundation

class ScClient: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocket) {
        print("websocket is connected")
        socket.write(string: "{\"event\":\"#handshake\",\"data\":{\"authToken\":null},\"cid\":1}")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
            print("websocket disconnected")
        }
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("got some text: \(text)")
        if (text == "#1") {
            socket.write(string: "#2")
        }
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("Received data: \(data.count)")
    }
    
    
    var socket = WebSocket(url: URL(string: "http://localhost:8000/socketcluster/")!)
    
    init() {
        socket.delegate = self
    }
    
    func connect() {
        socket.connect()
    }
    
}

