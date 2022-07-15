import Foundation
import UIKit

public class TestUserService: UserService {
    
    public var user = User(fullName: "Test user", avatar: UIImage(named: "redCross")!, status: "Test status")
    
    public func userService(name: String) -> User? {
        let newUser = User(fullName: name, avatar: UIImage(named: "") ?? UIImage(named: "redCross")!, status: "")
        
        if user.fullName == newUser.fullName {
            return user
        } else {
            return nil
        }
    }
}
