import Foundation
import Firebase

protocol LoginViewControllerDelegate {
    func checkCredentials(email: String, password: String, complition: @escaping (String) -> Void)
    func signUp(email: String, password: String, complition: @escaping (String) -> Void)
}

class LoginInspector: CheckerServiceProtocol, LoginViewControllerDelegate {
    
    func checkCredentials(email: String, password: String, complition: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                let result = error?.localizedDescription as? String
                if let result = result {
                    complition(result)
                }
            } else {
                complition("Success authorization")
            }
        }
    }
    
    func signUp(email: String, password: String, complition: @escaping (String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                let result = error?.localizedDescription as? String
                if let res = result {
                    complition(res)
                }
            } else {
                complition("Success registration")
            }
        }
    }
    
    
    
    
    //    let checker = Checker.shared
    //
    //    func checkLogin(login: String, password: String) -> Bool {
    //        checker.chckLogin(login: login, password: password)
    //    }
}


