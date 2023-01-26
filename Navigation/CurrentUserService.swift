import Foundation
import UIKit

public class CurrentUserService: UserService {
    
    public var user = User(fullName: "Hipster-Cat", avatar: UIImage(named: "cartoon-cat")!, status: "Listening to music")
    
    public func userService(name: String) -> User? {
        let newUser = User(fullName: name, avatar: UIImage(named: "") ?? UIImage(named: "redCross")!, status: "")
        
        if user.fullName == newUser.fullName {
            return user
        } else {
            return nil
        }
    }
}
