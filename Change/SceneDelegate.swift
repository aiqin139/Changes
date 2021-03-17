//
//  SceneDelegate.swift
//  Change
//
//  Created by aiqin139 on 2021/3/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var savedShortCutItem: UIApplicationShortcutItem!
    
    /// - Tag: willConnectTo
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        /** Process the quick action if the user selected one to launch the app.
            Grab a reference to the shortcutItem to use in the scene.
        */
        if let shortcutItem = connectionOptions.shortcutItem {
            // Save it off for later when we become active.
            savedShortCutItem = shortcutItem
        }
    }

    // MARK: - Application Shortcut Support
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        /** In this sample an alert is being shown to indicate that the action has been triggered,
            but in real code the functionality for the quick action would be triggered.
        */
        if shortcutItem.type == "Digital" {
            print("digital triggered")
        }
        else if  shortcutItem.type ==  "Dayan" {
            print("dayan triggered")
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
