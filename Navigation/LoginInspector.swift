import Foundation

class LoginInspector: LoginViewControllerDelegate {
    let checker = Checker.shared
    
    func checkLogin(login: String, password: String) -> Bool {
        checker.chckLogin(login: login, password: password)
    }
}
