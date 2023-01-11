
import Foundation
import RealmSwift

class RealmUser : Object {
    @Persisted var login : String?
    @Persisted var password: String?
    @Persisted var isAuth: Bool?

    convenience init(login: String, password: String) {
           self.init()
           self.login = login
           self.password = password
       }
}
