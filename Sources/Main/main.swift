import Foundation
import ScClient

var client = ScClient(url: "http://localhost:8000/socketcluster/")

client.connect()

while(true) {
    RunLoop.current.run(until: Date())
    usleep(10)
}

