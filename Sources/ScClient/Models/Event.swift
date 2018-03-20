import HandyJSON

class EmitEvent: HandyJSON {
    
    var event: String!
    var data: AnyObject?
    var cid: Int!
    
    required init() {
    }
    
    init(event: String, data: AnyObject?, cid : Int) {
        self.event = event
        self.data = data
        self.cid = cid
    }
    
}

class ReceiveEvent : HandyJSON {
    var data : AnyObject?
    var error : AnyObject?
    var rid : Int!

    
    convenience init(data : AnyObject? , error : AnyObject?, rid : Int) {
        self.init()
        self.data = data
        self.error = error
        self.rid = rid
    }
    
    required init() {
    }
}

class Channel : HandyJSON{
  var channel : String!
  var data : AnyObject?
  
  
  
  init(channel : String, data : AnyObject?) {
    self.channel = channel
    self.data = data
  }
  
  required init() {
  }
}

class SphereChannel : HandyJSON{
  var channel : String!
  var data : Data?
  
  init(channel : String, token: String) {
    self.channel = channel
    self.data = ChannelData(jwt: token)
  }
  
  required init() {
  }
}

class ChannelData {
  
  let jwt: String
  
  init(jwt: String) {
    self.jwt = jwt
  }
  
  
}

class AuthData : HandyJSON{
    var authToken : String?
    
    
    init(authToken : String?) {
        self.authToken = authToken
    }
    
    required init() {
    }
}

class HandShake  : HandyJSON {

    
    var event : String!
    var data  : AuthData!
    var cid   : Int!

    
    init(event : String, data : AuthData, cid : Int) {
        self.event = event
        self.data = data
        self.cid = cid
    }
    
    required init() {
    }
    
}

class Model  {
    
    public static func getEmitEventObject(eventName: String, data : AnyObject?, messageId : Int) -> EmitEvent{
        return EmitEvent(event: eventName, data: data, cid: messageId)
    }
    
    public static func getReceiveEventObject(data : AnyObject?, error : AnyObject?, messageId : Int) -> ReceiveEvent{
        return ReceiveEvent(data: data, error: error, rid: messageId)
    }
    
    public static func getChannelObject (data : AnyObject?) -> Channel? {
        if let channel = data as? [String : Any] {
            return Channel(channel: channel["channel"] as! String, data: channel["data"] as AnyObject)
        }
        return nil
    }
  
    public static func getSubscribeEventObject(channelName : String, messageId : Int, token: String) -> EmitEvent{
      return EmitEvent(event: "#subscribe", data: SphereChannel(channel: channelName, token: token) as AnyObject, cid: messageId)
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
