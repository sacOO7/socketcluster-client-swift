public class ClientUtils {
    
    public static func getAuthToken(message : Any?) -> String? {
        if let items = message as? [String : Any] {
            if let data = items["data"] as? [String : Any] {
                return data["token"] as? String
            }
        }
        return nil
    }
    
    public static func getIsAuthenticated(message : Any?) -> Bool? {
        
        if let items = message as? [String : Any] {
            if let data = items["data"] as? [String : Any] {
                return data["isAuthenticated"] as? Bool
            }
        }
        return nil
    }
    
}
