//
//  AppDelegate.swift
//  loodos
//
//  Created by Berkay Delen on 19.08.2020.
//

import UIKit
import Firebase
import FirebaseRemoteConfig

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static var view_window: UIWindow!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        AppDelegate.view_window = UIWindow(frame: UIScreen.main.bounds)





        getRemoteConfig()



        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    func getRemoteConfig() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if InternetConnectionManager.isConnectedToNetwork(){
                APIClient.getRemoteConfig { (success, error) in
                    print("Status -> \(success)")
                    print("Error -> \(error)")
                    if success{
                        timer.invalidate()
                    }
                }
            }

        }
    }


}

