//
//  SceneDelegate.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }

            // Create an instance of TriviaViewController
            let triviaViewController = TriviaViewController()

            // Set up a navigation controller with the TriviaViewController as the root
            let navigationController = UINavigationController(rootViewController: triviaViewController)

            // Create a new UIWindow using the windowScene constructor
            window = UIWindow(windowScene: windowScene)

            // Set the root view controller of the window
            window?.rootViewController = navigationController

            // Make the window visible
            window?.makeKeyAndVisible()
        }


    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

