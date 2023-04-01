import Foundation
import UIKit

final class Factory {
    enum Flow {
        case feedVC
        case loginVC
        case mapVC
        case authVC
        case profileVC
    }
    
    let navigationController: UINavigationController
    let flow: Flow
    
    init(navigatonController: UINavigationController, flow: Flow) {
        self.navigationController = navigatonController
        self.flow = flow
        startModule()
    }
    
    func startModule() {
        switch flow {
            
        case .loginVC:
            let loginViewController = LogInViewController()
            let loginInspectorFactory = MakeLoginInspector()
            loginViewController.delegate = loginInspectorFactory.createLoginInspector()
            navigationController.tabBarItem = UITabBarItem(title: "login", image: UIImage(systemName: "house.fill"), tag: 1)
            navigationController.setViewControllers([loginViewController], animated: true)
        case .mapVC:
            let mapViewController = MapViewController()
            navigationController.tabBarItem = UITabBarItem(title: "map", image: UIImage(systemName: "map.fill"), tag: 2)
            navigationController.setViewControllers([mapViewController], animated: true)
        case .authVC:
            let authVC = AuthenticationViewController()
            navigationController.setViewControllers([authVC], animated: true)
            navigationController.tabBarItem.isEnabled = false
        case .feedVC:
            let feedVC = FeedViewController()
            navigationController.tabBarItem = UITabBarItem(title: "FEED", image: UIImage(systemName: "list.star"), tag: 1)
            navigationController.setViewControllers([feedVC], animated: true)
//            navigationController.tabBarItem.isEnabled = false
        case .profileVC:
            let profileVC = ProfileViewController()
            navigationController.tabBarItem = UITabBarItem(title: "PROFILE", image: UIImage(systemName: "person.wave.2"), tag: 2)
            navigationController.setViewControllers([profileVC], animated: true)
//            navigationController.tabBarItem.isEnabled = false
            
        }
    }
}
