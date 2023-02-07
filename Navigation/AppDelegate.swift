
import UIKit
import Firebase
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        UserDefaults.standard.set("adsfddvcscdvdvfbfbfbfbkhgtrewvbo57364kgdhfjt,xhftdsxkmvftygcxxxx", forKey: "key")
        
        
        
        
        //        let appConfiguration: AppConfiguration = .peoples
        //        NetworkService.request(for: appConfiguration)
        //
        //        func createFeedViewController() -> UINavigationController {
        //            let feedVC = FeedViewController()
        //            feedVC.title = "Feed"
        //            feedVC.tabBarItem = UITabBarItem(title: "Feed", image: feedImage, tag: 0)
        //            return UINavigationController(rootViewController: feedVC)
        //        }
        //
        //        func createLogInViewController() -> UINavigationController {
        //            let logInVC = LogInViewController()
        //            logInVC.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 1)
        //            logInVC.delegate = self
        //            return UINavigationController(rootViewController: logInVC)
        //        }
        //
        //        func createTabBarController() -> UITabBarController {
        //            let tabBarController = UITabBarController()
        //            UITabBar.appearance().backgroundColor = .systemGray6
        //            tabBarController.viewControllers = [createFeedViewController(), createLogInViewController()]
        //            return tabBarController
        //        }
        //
//        let authVC = AuthenticationViewController()
        let mainCoordinator = MainCoordinator()
//        self.window?.rootViewController = authVC
        self.window?.rootViewController = mainCoordinator.startApplication()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
}









