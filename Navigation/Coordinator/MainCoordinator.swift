import Foundation
import UIKit

protocol MainCoordinatorProtocol {
    func startApplication() -> UIViewController
}

final class MainCoordinator: MainCoordinatorProtocol {
    func startApplication() -> UIViewController {
        return MainTabbarViewController()
    }
    
    
}
