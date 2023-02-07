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
    private let authVC = Factory(navigatonController: UINavigationController(), flow: .authVC)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        
        
    }
    
    private func setupControllers() {
        viewControllers = [authVC.navigationController, feedVC.navigationController, mapVC.navigationController, loginVC.navigationController]
    }

    
}
