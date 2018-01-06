import Foundation
import ScClient

var client = ScClient()

client.connect()

while(true) {
    RunLoop.current.run(until: Date())
    usleep(10)
}

