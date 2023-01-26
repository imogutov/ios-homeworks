import Foundation
import UIKit

final class Factory {
    enum Flow {
        case feedVC
        case loginVC
        case mapVC
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
            
        case .feedVC:
            let feedViewController = FeedViewController()
            navigationController.tabBarItem = UITabBarItem(title: "feed", image: UIImage(systemName: "person.fill"), tag: 0)
            navigationController.setViewControllers([feedViewController], animated: true)
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
        }
    }
}
