struct EmitEvent {
    var event: String
    var data: AnyObject?
    var cid: Int
}

struct ReceiveEvent {
    var data : AnyObject?
    var error : AnyObject?
    var rid : Int
}

struct Channel {
    var channel : String
    var data : AnyObject?
}

struct AuthData {
    var authToken : String?
}

struct HandShake  {
    var event : String
    var data  : AuthData
    var cid   : Int
}

class Model  {
    
    public static func getEmitEventObject(eventName: String, data : AnyObject?, messageId : Int) -> EmitEvent{
        return EmitEvent(event: eventName, data: data, cid: messageId)
    }
    
    public static func getReceiveEventObject(data : AnyObject?, error : AnyObject?, messageId : Int) -> ReceiveEvent{
        return ReceiveEvent(data: data, error: error, rid: messageId)
    }
    
//    public static func getChannelObject (data : AnyObject?) -> Channel {
//        
//    }
    
    public static func getSubscribeEventObject(channelName : String, messageId : Int) -> EmitEvent{
        return EmitEvent(event: "#subscribe", data: Channel(channel: channelName, data :nil) as AnyObject, cid: messageId)
    }
    
    
    public static func getUnsubscribeEventObject(channelName : String, messageId : Int) -> EmitEvent{
        return EmitEvent(event: "#unsubscribe", data: Channel(channel: channelName, data :nil) as AnyObject, cid: messageId)
    }
    
    public static func getPublishEventObject(channelName : String, data : AnyObject?, messageId : Int) -> EmitEvent{
        return EmitEvent(event: "#publish", data: Channel(channel: channelName, data :data) as AnyObject, cid: messageId)
    }
    
    public static func getHandshakeObject(authToken : String?, messageId : Int) -> HandShake{
        return HandShake(event: "#handshake", data: AuthData(authToken: authToken), cid: messageId)
    }
    
    
}
