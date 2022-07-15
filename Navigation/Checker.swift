import UIKit

final class Checker {
    
    static let shared = Checker()
    
    private init() {}
    
    private let staticLogin = "HipsterCat"
    private let staticPswd = "123"
    
    func chckLogin(login: String, password: String) -> Bool {
        if staticLogin == login, staticPswd == password {
            return true
        } else {
            return false
        }
    }
}
