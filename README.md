# socketcluster-client-swift
Native iOS/macOS client written in swift
    
Overview
--------
This client provides following functionality

- Easy to setup and use
- Support for emitting and listening to remote events
- Pub/sub
- Authentication (JWT)

<!---
To install use

 ```markdown
    go get github.com/sacOO7/socketcluster-client-go/scclient
 ```
 --->

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

- eventname is name of event and message can be String, boolean, int or structure

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

<!---

#### Event Listener

- For listening to events :

The object received can be String, Boolean, Long or GO structure.

```go
    // Receiver code without sending acknowledgement back
    client.On("chat", func(eventName string, data interface{}) {
		fmt.Println("Got data ", data, " for event ", eventName)
	})
    
```

- To send acknowledgement back to server

```go
    // Receiver code with ack
	client.OnAck("chat", func(eventName string, data interface{}, ack func(error interface{}, data interface{})) {
		fmt.Println("Got data ", data, " for event ", eventName)
		fmt.Println("Sending back ack for the event")
		ack("This is error", "This is data")
	}) 
        
```

Implementing Pub-Sub via channels
---------------------------------

#### Creating channel

- For creating and subscribing to channels:

```go
    // without acknowledgement
    client.Subscribe("mychannel")
    
    //with acknowledgement
    client.SubscribeAck("mychannel", func(channelName string, error interface{}, data interface{}) {
        if error == nil {
            fmt.Println("Subscribed to channel ", channelName, "successfully")
        }
    })
```


#### Publishing event on channel

- For publishing event :

```go

       // without acknowledgement
       client.Publish("mychannel", "This is a data to be published")

       
       // with acknowledgement
       client.PublishAck("mychannel", "This is a data to be published", func(channelName string, error interface{}, data interface{}) {
       		if error == nil {
       			fmt.Println("Data published successfully to channel ", channelName)
       		}
       	})
``` 
 
#### Listening to channel

- For listening to channel event :

```go
        client.OnChannel("mychannel", func(channelName string, data interface{}) {
        		fmt.Println("Got data ", data, " for channel ", channelName)
        })
    
``` 
     
#### Un-subscribing to channel

```go
         // without acknowledgement
        client.Unsubscribe("mychannel")
         
         // with acknowledgement
        client.UnsubscribeAck("mychannel", func(channelName string, error interface{}, data interface{}) {
            if error == nil {
                fmt.Println("Unsubscribed to channel ", channelName, "successfully")
            }
        })
```
--->
