//
//  AppDelegate.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 8. 30..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let log:String = "LogTag"
    
    let blueInspireColor = UIColor(red: 34/255.0, green: 45/255.0, blue: 103/255.0, alpha: 1.0)
    
    var window: UIWindow?
    
    var userinfo: UserInfo?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        FUIAuth.defaultAuthUI()?.delegate = self as? FUIAuthDelegate
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : blueInspireColor]
        
        self.window?.makeKey()
        
        initViewController()
        
        return true
    }
    
    func initViewController(){
        guard let decoded = UserDefaults.standard.object(forKey: "user") as? Data, let userinfo = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? UserInfo else {
            self.window?.rootViewController =
                CommonUtils.sharedInstance
                    .mainStoryboard
                    .instantiateViewController(withIdentifier: "LoginViewController")
                as! LoginViewController
            return
        }
        
        CommonUtils.sharedInstance.setUser(user: userinfo)
        
        self.window?.rootViewController =
            CommonUtils.sharedInstance
                .mainStoryboard
                .instantiateViewController(withIdentifier: "CheckAuthViewController")
            as! CheckAuthViewController
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

