import Foundation

protocol LoginFactory {
    func createLoginInspector() -> LoginInspector
}

final class MakeLoginInspector: LoginFactory {
    func createLoginInspector() -> LoginInspector {
        let loginInspector = LoginInspector()
        return loginInspector
    }
}
