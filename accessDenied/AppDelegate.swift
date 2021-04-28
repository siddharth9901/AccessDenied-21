//
//  AppDelegate.swift
//  accessDenied
//
//  Created by riddhi gupta on 01/02/21.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseMessaging
@main
class AppDelegate: UIResponder, UIApplicationDelegate{

    let gcmMessageIDKey = "accessDenied'21"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
                if #available(iOS 10.0, *) {
                  UNUserNotificationCenter.current().delegate = self
                  Messaging.messaging().delegate = self
                  let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                  UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_, _ in })
                } else {
                  let settings: UIUserNotificationSettings =
                  UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                  application.registerUserNotificationSettings(settings)
                }
                application.registerForRemoteNotifications()
        
        IQKeyboardManager.shared.enable = true
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
           if let messageID = userInfo[gcmMessageIDKey] {
               print("Message ID: \(messageID)")
           }
           print(userInfo)
       }

       func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
           if let messageID = userInfo[gcmMessageIDKey] {
               print("Message ID: \(messageID)")
           }
           print(userInfo)
           completionHandler(UIBackgroundFetchResult.newData)
       }
       
       // MARK:- UISceneSession Lifecycle
       func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
           return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
       }

       func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       }


   }
   //MARK: - MessagingDelegate
   extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
         print("Firebase registration token: \(fcmToken)")

         let dataDict:[String: String] = ["token": "\(fcmToken)"]
         NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
       }
   }
   //MARK: -  UNUserNotificationCenterDelegate
   @available(iOS 10, *)
   extension AppDelegate : UNUserNotificationCenterDelegate {

     func userNotificationCenter(_ center: UNUserNotificationCenter,
                                 willPresent notification: UNNotification,
       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       let userInfo = notification.request.content.userInfo
       if let messageID = userInfo[gcmMessageIDKey] {
         print("Message ID: \(messageID)")
       }
       completionHandler([[.alert, .sound]])
     }

     func userNotificationCenter(_ center: UNUserNotificationCenter,
                                 didReceive response: UNNotificationResponse,
                                 withCompletionHandler completionHandler: @escaping () -> Void) {
       completionHandler()
     }
   }
