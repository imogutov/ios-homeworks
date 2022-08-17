import UIKit

class MainTabbarViewController: UITabBarController {

    private let feedVC = Factory(navigatonController: UINavigationController(), flow: .feedVC)
    private let loginVC = Factory(navigatonController: UINavigationController(), flow: .loginVC)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        
    }
    
    private func setupControllers() {
        viewControllers = [feedVC.navigationController, loginVC.navigationController]
    }

    
}
