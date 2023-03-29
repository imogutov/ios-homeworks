import Foundation
import Firebase
import FirebaseFirestore

protocol LoginViewControllerDelegate {
    func checkCredentials(email: String, password: String, complition: @escaping (String) -> Void)
    func signUp(email: String, password: String, complition: @escaping (String) -> Void)
}

class LoginInspector: LoginViewControllerDelegate {
    
    let db = Firestore.firestore()
    
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
                let uid = result?.user.uid ?? "unknownUser"
                
                self.db.collection(uid).document("status").setData(["status": "status not set"]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                    complition("Success registration")
                }
            }
        }
    }
}


