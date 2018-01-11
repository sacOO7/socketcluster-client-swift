import Starscream
import Foundation


public class ScClient : WebSocketDelegate {
    
    var authToken : String?
    var url : String?
    var socket : WebSocket
    var counter : AtomicInteger
    
    var onConnect : ((ScClient)-> Void)?
    var onConnectError : ((ScClient, Error?)-> Void)?
    var onDisconnect : ((ScClient, Error?)-> Void)?
    var onSetAuthentication : ((ScClient, String?)-> Void)?
    var onAuthentication : ((ScClient, Bool?)-> Void)?
    
    
    
    public func setBasicListener(onConnect : ((ScClient)-> Void)?, onConnectError : ((ScClient, Error?)-> Void)?, onDisconnect : ((ScClient, Error?)-> Void)?) {
        self.onConnect = onConnect
        self.onDisconnect = onDisconnect
        self.onConnectError = onConnectError
    }
    
    public func setAuthenticationListener (onSetAuthentication : ((ScClient, String?)-> Void)?, onAuthentication : ((ScClient, Bool?)-> Void)?) {
        self.onSetAuthentication = onSetAuthentication
        self.onAuthentication = onAuthentication
    }
    
    public func websocketDidConnect(socket: WebSocket) {
        onConnect?(self)
        self.sendHandShake()
    }
    
    public func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        onDisconnect?(self, error)
    }
    
    public func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("got some text: \(text)")
        if (text == "#1") {
            socket.write(string: "#2")
        } else {
            if let messageObject = JSONConverter.deserializeString(message: text) {
                if let (data, rid, cid, eventName, error) = Parser.getMessageDetails(myMessage: messageObject) {
                    
                    let parseResult = Parser.parse(rid: rid, cid: cid, event: eventName)
                    
                    switch parseResult {
                        
                    case .isAuthenticated:
                        let isAuthenticated = ClientUtils.getIsAuthenticated(message: messageObject)
                        onAuthentication?(self, isAuthenticated)
                    case .publish:
                        break
                    case .removeToken:
                        break
                    case .setToken:
                        authToken = ClientUtils.getAuthToken(message: messageObject)
                        self.onSetAuthentication?(self, authToken)
                    case .event:
                        break
                    case .ackReceive:
                        break
                    }
                    
                }
            }
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
    
    private func sendHandShake() {
        let handshake = Model.getHandshakeObject(authToken: self.authToken, messageId: counter.incrementAndGet())
        socket.write(string: handshake.toJSONString()!)
    }
    
    public func disconnect() {
        socket.disconnect()
    }
    
}



