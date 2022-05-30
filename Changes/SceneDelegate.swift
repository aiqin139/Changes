//
//  SceneDelegate.swift
//  Changes
//
//  Created by aiqin139 on 2021/3/14.
//

import SwiftUI
import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var savedShortCutItem: UIApplicationShortcutItem!
    var modelData = ModelData()
    
    /// - Tag: willConnectTo
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        /** Process the quick action if the user selected one to launch the app.
            Grab a reference to the shortcutItem to use in the scene.
        */
        if let shortcutItem = connectionOptions.shortcutItem {
            // Save it off for later when we become active.
            savedShortCutItem = shortcutItem
        }
        
        // Create the UIKit view that provides the window contents.
        if let windowScene = scene as? UIWindowScene {
            let hostVC = UISplitViewController()
            hostVC.viewControllers = [CustomTabBarController(self.modelData)]
            hostVC.preferredDisplayMode = .oneBesideSecondary
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = hostVC
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    // MARK: - Application Shortcut Support
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        //Gets the splitViewController
        if let splitController = window?.rootViewController as? UISplitViewController {
            //Gets the tabbarController
            if let tabbarController = splitController.viewControllers[0] as?  UITabBarController {
                //Gets the navigationViewController
                if let navController = tabbarController.viewControllers?[0] as? UINavigationController {
                    //Push DigitalPredictionView
                    if shortcutItem.type == "Digital" {
                        let view = DigitalPredictionView().environmentObject(modelData)
                        let hostVC = UIHostingController(rootView: view)
                        if splitController.isCollapsed == false {
                            splitController.showDetailViewController(UINavigationController(rootViewController: hostVC), sender: self)
                        } else {
                            navController.popViewController(animated: true)
                            navController.pushViewController(hostVC, animated: true)
                        }
                    //Push DayanPredictionView
                    } else if shortcutItem.type ==  "Dayan" {
                        let view = DayanPredictionView().environmentObject(modelData)
                        let hostVC = UIHostingController(rootView: view)
                        if splitController.isCollapsed == false {
                            splitController.showDetailViewController(UINavigationController(rootViewController: hostVC), sender: self)
                        } else {
                            navController.popViewController(animated: true)
                            navController.pushViewController(hostVC, animated: true)
                        }
                    }
                }
            }
        }
        return true
    }
    
    /** Called when the user activates your application by selecting a shortcut on the Home Screen,
        and the window scene is already connected.
    */
    /// - Tag: PerformAction
    func windowScene(_ windowScene: UIWindowScene,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        let handled = handleShortCutItem(shortcutItem: shortcutItem)
        completionHandler(handled)
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        if savedShortCutItem != nil {
            _ = handleShortCutItem(shortcutItem: savedShortCutItem)
        }
    }
    
    /// - Tag: SceneWillResignActive
    func sceneWillResignActive(_ scene: UIScene) {
        var digitaluserInfo: [String: NSSecureCoding] { return ["name" : "Digital" as NSSecureCoding] }
        var dayanuserInfo: [String: NSSecureCoding] { return ["name" : "Dayan" as NSSecureCoding] }
        
        // Transform each favorite contact into a UIApplicationShortcutItem.
        let application = UIApplication.shared
        application.shortcutItems = [
            UIApplicationShortcutItem(type: "Digital", localizedTitle: "数字卦", localizedSubtitle: "占小事", icon: UIApplicationShortcutIcon(systemImageName: "star"), userInfo: digitaluserInfo),
            UIApplicationShortcutItem(type: "Dayan", localizedTitle: "大衍卦", localizedSubtitle: "占大事", icon: UIApplicationShortcutIcon(systemImageName: "star"), userInfo: dayanuserInfo),
        ]
    }
}
