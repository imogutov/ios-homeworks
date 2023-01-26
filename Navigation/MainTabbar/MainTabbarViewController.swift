import UIKit

class MainTabbarViewController: UITabBarController {
    
//    let logInspCompFactory = MakeLoginInspector()
//    lazy var loginInspector = logInspCompFactory.createLoginInspector()
//    
//    func checkLogin(login: String, password: String) -> Bool {
//        loginInspector.checkLogin(login: login, password: password)
//    }
    

    private let feedVC = Factory(navigatonController: UINavigationController(), flow: .feedVC)
    private let loginVC = Factory(navigatonController: UINavigationController(), flow: .loginVC)
    private let mapVC = Factory(navigatonController: UINavigationController(), flow: .mapVC)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        
    }
    
    private func setupControllers() {
        viewControllers = [feedVC.navigationController, loginVC.navigationController, mapVC.navigationController]
    }

    
}
