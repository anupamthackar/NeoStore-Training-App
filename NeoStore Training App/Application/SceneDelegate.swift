//
//  SceneDelegate.swift
//  NeoStore Training App
//
//  Created by Neosoft on 17/07/24.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // Core Data stack
        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "YourDataModelName")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()

        // MARK: - Core Data Saving support
        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

        func sceneDidEnterBackground(_ scene: UIScene) {
            saveContext()
        }
        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(windowScene: windowScene)
            checkForAccessToken()
//            navigateToLogin()
        }

        private func checkForAccessToken() {
            if let _ = UserDefaults.standard.string(forKey: "accessToken") {
                navigateToHome()
            } else {
                navigateToLogin()
            }
        }

        private func navigateToHome() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            window?.rootViewController = UINavigationController(rootViewController: homeVC)
            window?.makeKeyAndVisible()
        }

        private func navigateToLogin() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            window?.rootViewController = UINavigationController(rootViewController: loginVC)
            window?.makeKeyAndVisible()
        }
        func logout() {
            // Clear user data
            UserDefaults.standard.removeObject(forKey: "accessToken")
            UserDefaults.standard.removeObject(forKey: "firstName")
            UserDefaults.standard.removeObject(forKey: "lastName")
            UserDefaults.standard.removeObject(forKey: "email")
            
            // Redirect to login
            navigateToLogin()
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }




