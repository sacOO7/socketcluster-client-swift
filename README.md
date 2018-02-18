# socketcluster-client-swift
Native iOS/macOS client written in swift
    
Overview
--------
This client provides following functionality

- Easy to setup and use
- Support for emitting and listening to remote events
- Pub/sub
- Authentication (JWT)


Installation and Use
--------------------

### [CocoaPods](http://cocoapods.org)

```ruby
pod 'ScClient', :git => 'https://github.com/sacOO7/socketcluster-client-swift.git'
```

### Swift Package Manager

- To install add this to depedencies section of Package.swift

 ```swift
     dependencies: [
     	// other dependencies 
    	.package(url: "https://github.com/sacOO7/ScClient", from: "1.0.1")
	]
 ```
- To use the library add this to target dependencies

 ```swift
    targets: [
        .target(
            name: "tool",
            dependencies: [
                "ScClient"
            ])
    ]
 ```

Description
-----------
Create instance of `scclient` by passing url of socketcluster-server end-point 

```swift
    //Create a client instance
    var client = ScClient(url: "http://localhost:8000/socketcluster/")
    
```
**Important Note** : Default url to socketcluster end-point is always *ws://somedomainname.com/socketcluster/*.

#### Registering basic listeners
 
- Different closure functions are given as an argument to register listeners
- Example : main.swift

```swift
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
            startCode(client : client)
        }

        var onSetAuthentication = {
            (client : ScClient, token : String?) in
            print("Token is ", token)
        }
        client.setBasicListener(onConnect: onConnect, onConnectError: nil, onDisconnect: onDisconnect)
        client.setAuthenticationListener(onSetAuthentication: onSetAuthentication, onAuthentication: onAuthentication)
        
        client.connect()
        
        while(true) {
            RunLoop.current.run(until: Date())
            usleep(10)
        }
        
        func startCode(client scclient.Client) {
        	// start writing your code from here
        	// All emit, receive and publish events
        }
        
```


#### Connecting to server

- For connecting to server:

```swift 
    //This will send websocket handshake request to socketcluster-server
    client.connect()
```

Emitting and listening to events
--------------------------------
#### Event emitter

- eventname is name of event and message can be String, boolean, Int or Object

```swift

    client.emit(eventName: eventname, data: message as AnyObject)
    
  //client.emit(eventName: "chat", data: "This is my sample message" as AnyObject)
  
```

- To send event with acknowledgement

```swift

    client.emitAck(eventName: "chat", data: "This is my sample message" as AnyObject, ack : {
    	    (eventName : String, error : AnyObject? , data : AnyObject?) in
            print("Got data for eventName ", eventName, " error is ", error, " data is ", data)  
    })
	
```

#### Event Listener

- For listening to events :

The object received can be String, Boolean, Int or Object

```swift
    // Receiver code without sending acknowledgement back
    client.on(eventName: "yell", ack: {
    	    (eventName : String, data : AnyObject?) in
            print("Got data for eventName ", eventName, " data is ", data)
    })
    
```

- To send acknowledgement back to server

```swift
    // Receiver code with ack
    client.onAck(eventName: "yell", ack: {
            (eventName : String, data : AnyObject?, ack : (AnyObject?, AnyObject?) -> Void) in
            print("Got data for eventName ", eventName, " data is ", data)
            ack("This is error " as AnyObject, "This is data " as AnyObject)
    })
        
```



Implementing Pub-Sub via channels
---------------------------------

#### Creating channel

- For creating and subscribing to channels:

```swift 
    // without acknowledgement
    client.subscribe(channelName: "yell")
    
    //with acknowledgement
    client.subscribeAck(channelName: "yell", ack : {
        (channelName : String, error : AnyObject?, data : AnyObject?) in
        if (error is NSNull) {
            print("Successfully subscribed to channel ", channelName)
        } else {
            print("Got error while subscribing ", error)
        }
    })
```


#### Publishing event on channel

- For publishing event :

```swift

	// without acknowledgement
	client.publish(channelName: "yell", data: "I am sending data to yell" as AnyObject)


	// with acknowledgement
	client.publishAck(channelName: "yell", data: "I am sending data to yell" as AnyObject, ack : {
		(channelName : String, error : AnyObject?, data : AnyObject?) in
		if (error is NSNull) {
		     print("Successfully published to channel ", channelName)
		}else {
		     print("Got error while publishing ", error)
		}
	})
``` 
 
#### Listening to channel

- For listening to channel event :

```swift
        client.onChannel(channelName: "yell", ack: {
    		(channelName : String , data : AnyObject?) in
    		print ("Got data for channel", channelName, " object data is ", data)
	})
``` 
     
#### Un-subscribing to channel

```swift
    // without acknowledgement
    client.unsubscribe(channelName: "yell")
    
    //with acknowledgement
    client.unsubscribeAck(channelName: "yell", ack : {
        (channelName : String, error : AnyObject?, data : AnyObject?) in
        if (error is NSNull) {
            print("Successfully unsubscribed to channel ", channelName)
        } else {
            print("Got error while unsubscribing ", error)
        }
    })
```

