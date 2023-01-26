import Foundation
import UIKit

public class TestUserService: UserService {
    
    public var user = User(fullName: "Test user", avatar: UIImage(named: "redCross")!, status: "Test status")
    
    public func userService(name: String) -> User? {
        return user.fullName == name ? user : nil
    }
}
