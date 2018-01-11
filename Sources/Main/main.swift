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

client.setBasicListener(onConnect: onConnect, onConnectError: nil, onDisconnect: onDisconnect)

client.connect()

while(true) {
    RunLoop.current.run(until: Date())
    usleep(10)
}

