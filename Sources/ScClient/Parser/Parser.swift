public enum MessageType {
    case isAuthenticated
    case publish
    case removeToken
    case setToken
    case event
    case ackReceive
}

public class Parser {
    
    public static func parse(rid : Int?, cid : Int?, event : String?) -> MessageType {
        if (event != nil) {
            if (event == "#publish") {
                return MessageType.publish
            } else if (event == "#removeAuthToken") {
                return MessageType.removeToken
            } else if (event == "#setAuthToken") {
                return MessageType.setToken
            } else {
                return MessageType.event
            }
        } else if (rid == 1) {
            return MessageType.isAuthenticated
        } else {
            return MessageType.ackReceive
        }
    }
    
    public static func getMessageDetails(myMessage : Any) -> (data: Any?, rid : Int?, cid : Int?, eventName : String?, error : Any?)? {
        if let messageItem = myMessage as? [String: Any] {
            let data = messageItem["data"]
            let rid = messageItem["rid"] as? Int
            let cid = messageItem["cid"] as? Int
            let event = messageItem["event"] as? String
            let error = messageItem["error"]
            return (data, rid, cid, event, error)
        }
        return nil
        
    }
}

