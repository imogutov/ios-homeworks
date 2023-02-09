
import UIKit
import Firebase
import RealmSwift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        UserDefaults.standard.set("adsfddvcscdvdvfbfbfbfbkhgtrewvbo57364kgdhfjt,xhftdsxkmvftygcxxxx", forKey: "key")
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let notificationService = LocalNotificationsService()
        notificationService.registeForLatestUpdatesIfPossible()
        notificationService.scheduleNotification()
        
        let mainCoordinator = MainCoordinator()
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

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "Dismiss":
            break
        default:
            break
        }
        completionHandler()
    }
}







