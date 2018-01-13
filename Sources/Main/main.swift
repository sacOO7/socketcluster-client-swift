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
    client.subscribeAck(channelName: "yell", ack : {
        (channelName : String, error : AnyObject?, data : AnyObject?) in
        if (error is NSNull) {
            print("Successfully subscribed to channel ", channelName)
        } else {
            print("Got error while subscribing ", error)
        }
        
    })
    
    client.publishAck(channelName: "yell", data: "I am sending data to yell" as AnyObject, ack : {
        (channelName : String, error : AnyObject?, data : AnyObject?) in
        if (error is NSNull) {
            print("Successfully published to channel ", channelName)
        }else {
             print("Got error while publishing ", error)
        }
        
    })
}

client.setBasicListener(onConnect: onConnect, onConnectError: nil, onDisconnect: onDisconnect)
client.setAuthenticationListener(onSetAuthentication: onSetAuthentication, onAuthentication: onAuthentication)

client.onChannel(channelName: "yell", ack: {
    (channelName : String , data : AnyObject?) in
    print ("Got data for channel", channelName, " object data is ", data)
})

client.connect()

while(true) {
    RunLoop.current.run(until: Date())
    usleep(10)
}

