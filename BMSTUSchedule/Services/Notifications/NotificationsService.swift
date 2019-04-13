//
//  NotificationsService.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 12/04/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation
import UserNotifications
import Firebase

class NotificationsService: NSObject {

    weak var application: UIApplication?
    
    func registerForRemoteNotifications() {        
        Messaging.messaging().delegate = self
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
//                self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
            }
        }
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application?.registerUserNotificationSettings(settings)
        }
        
        
        application?.registerForRemoteNotifications()
    }
    
    func handle(_ notification: [AnyHashable : Any]) {
//        Messaging.messaging().appDidReceiveMessage(notification)
        
        // Print full message.
        print("Recieved remote notification: \(notification)")
    }
}

extension NotificationsService: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)

        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

@available(iOS 10, *)
extension NotificationsService: UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        handle(userInfo)
        
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        handle(userInfo)
        
        completionHandler()
    }
}
