import UIKit
import Firebase

class MainTabbarViewController: UITabBarController {
    
//    let logInspCompFactory = MakeLoginInspector()
//    lazy var loginInspector = logInspCompFactory.createLoginInspector()
//
//    func checkLogin(login: String, password: String) -> Bool {
//        loginInspector.checkLogin(login: login, password: password)
//    }
    
    private let feedVC = Factory(navigatonController: UINavigationController(), flow: .feedVC)
    private let profileVC = Factory(navigatonController: UINavigationController(), flow: .profileVC)
    private let loginVC = Factory(navigatonController: UINavigationController(), flow: .loginVC)
    private let mapVC = Factory(navigatonController: UINavigationController(), flow: .mapVC)
    private let authVC = Factory(navigatonController: UINavigationController(), flow: .authVC)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        
        
    }
    
    private func setupControllers() {
        if Auth.auth().currentUser == nil {
            viewControllers = [loginVC.navigationController]
        } else {
            viewControllers = [authVC.navigationController, feedVC.navigationController, profileVC.navigationController]
        }
    }
    
}
