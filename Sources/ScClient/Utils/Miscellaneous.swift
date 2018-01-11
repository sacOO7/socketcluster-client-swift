import Foundation

public class JSONConverter {
    
    public static func deserializeString(message : String) -> [String : Any]? {
        let jsonObject = try? JSONSerialization.jsonObject(with: message.data(using: .utf8)!, options: [])
        return jsonObject as? [String : Any]
    }
    
    public static func deserializeData(data : Data) -> [String : Any]? {
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
        return jsonObject as? [String : Any]
    }
    
    public static func serializeObject(object : Any) -> String? {
        let message = try? JSONSerialization.data(withJSONObject: object, options: [])
        return String(data: message!, encoding: .utf8)
    }
}
