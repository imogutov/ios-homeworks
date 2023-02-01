import Foundation

final class Model {
    let password: String = "1"
    var check: Bool = true {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("myEvent"), object: nil)
        }
    }
    
    func check(word: String){
        if word == password {
            check = true
        } else {
            check = false
        }
    }
}
