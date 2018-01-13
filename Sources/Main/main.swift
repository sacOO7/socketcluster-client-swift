import Foundation
import ScClient

var client = ScClient(url: "http://localhost:8000/socketcluster/")

var onConnect = {
    (client :ScClient) in
    print("Connnected to server")
}

var onDisconnect = {
    (client :ScClient, error : Error?) in
        print("Disconnected from server due to ", error?.localizedDescription)
}

var onAuthentication = {
    (client :ScClient, isAuthenticated : Bool?) in
    print("Authenticated is ", isAuthenticated)
}

var onSetAuthentication = {
    (client : ScClient, token : String?) in
    print("Token is ", token)
    client.emitAck(eventName: "chat", data: "This is my sample data" as AnyObject, ack : {
        (eventName : String, error : AnyObject? , data : AnyObject?) in
        print("Got data for eventName", eventName, " error is ", error, " data is ", data)
        
    })
}

client.setBasicListener(onConnect: onConnect, onConnectError: nil, onDisconnect: onDisconnect)
client.setAuthenticationListener(onSetAuthentication: onSetAuthentication, onAuthentication: onAuthentication)
client.onAck(eventName: "yell", ack: {
    (eventName : String, data : AnyObject?, ack : (AnyObject?, AnyObject?) -> Void) in
    print("Got data for eventName ", eventName, " data is ", data)
    ack(nil, nil)
})

client.connect()

while(true) {
    RunLoop.current.run(until: Date())
    usleep(10)
}

