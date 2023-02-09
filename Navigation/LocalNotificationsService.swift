//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Ivan Mogutov on 07.02.2023.
//

import Foundation
import UserNotifications

class LocalNotificationsService {
    
    private enum LocalizedKeys: String {
        case updateTitle = "somethingNew"
        case updateBody = "lookAtYourUpdates"
        case dismiss = "dismiss"
    }
    
    func registeForLatestUpdatesIfPossible() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.provisional, .badge, .sound]) { success, error in
            if let error {
                print(error)
            }
        }
    }
    
    func scheduleNotification() {
        registerUpdatesCategory()
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = ~LocalizedKeys.updateTitle.rawValue
        content.body = ~LocalizedKeys.updateBody.rawValue
        content.sound = .default
        content.categoryIdentifier = "updates"
        
        var components = DateComponents()
        components.hour = 19
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerUpdatesCategory() {
        let center = UNUserNotificationCenter.current()
        let actionDismiss = UNNotificationAction(identifier: "Dismiss", title: ~LocalizedKeys.dismiss.rawValue, options: .destructive)
        let category1 = UNNotificationCategory(identifier: "updates", actions: [actionDismiss], intentIdentifiers: [])
        let categories: Set<UNNotificationCategory> = [category1]
        center.setNotificationCategories(categories)
    }
}

