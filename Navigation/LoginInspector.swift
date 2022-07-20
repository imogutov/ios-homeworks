import Foundation

class LoginInspector: LoginViewControllerDelegate {
    let checker = Checker.shared
    
    func checkLogin(login: String, password: String) -> Bool {
        
        if checker.chckLogin(login: login, password: password) == true {
            return true
        } else {
            return false
        }
    }
}
