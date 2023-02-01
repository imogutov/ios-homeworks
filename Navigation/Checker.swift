import UIKit

final class Checker {
    
    static let shared = Checker()
    
    private init() {}
    
    private let staticLogin = "1"
    private let staticPswd = "1"
    
    func chckLogin(login: String, password: String) -> Bool {
        if staticLogin == login, staticPswd == password {
            return true
        } else {
            return false
        }
    }
}
