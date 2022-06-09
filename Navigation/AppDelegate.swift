
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let profileImage = UIImage(systemName: "person.fill")
    let feedImage = UIImage(systemName: "house.fill")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        func createFeedViewController() -> UINavigationController {
            let feedVC = FeedViewController()
            feedVC.title = "Feed"
            feedVC.tabBarItem = UITabBarItem(title: "Feed", image: feedImage, tag: 0)
            return UINavigationController(rootViewController: feedVC)
        }
        
        func createLogInViewController() -> UINavigationController {
            let logInVC = LogInViewController()
            logInVC.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 1)
            return UINavigationController(rootViewController: logInVC)
        }
        
        func createTabBarController() -> UITabBarController {
            let tabBarController = UITabBarController()
            UITabBar.appearance().backgroundColor = .systemGray6
            tabBarController.viewControllers = [createFeedViewController(), createLogInViewController()]
            return tabBarController
        }
        
        self.window?.rootViewController = createTabBarController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
