//
//  SceneDelegate.swift
//  DragonBallRCO
//
//  Created by Renato Calderon on 21/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        
            // Desempaquetamos la scene
            guard let scene = (scene as? UIWindowScene) else { return }
            // Creamos un objeto window
            let window = UIWindow(windowScene: scene)
            // Instanciamos un tab bar
            let tabBarController = UITabBarController()
            // Instanciamos nuestra lista de casas
            let mainListViewController = LoginViewController() //MainListViewController()
            mainListViewController.tabBarItem = UITabBarItem(
                title: "Universo de Dragon Ball",
                image: UIImage(systemName: "star.circle"),
                //selectedImage: UIImage(systemName: "star.circle.fill")?.withRenderingMode(.alwaysOriginal)
                selectedImage: UIImage(systemName: "star.circle.fill")?.withRenderingMode(.alwaysOriginal)
            )
            
            let navigationController = UINavigationController(rootViewController: mainListViewController    )
            /*let favouritesViewController = FavouriteHouseListViewController()
            favouritesViewController.tabBarItem = UITabBarItem(
                title: "Favourites",
                image: UIImage(systemName: "star"),
                selectedImage: UIImage(systemName: "star.fill")
            )
            let favouritesNavigationController = UINavigationController(rootViewController: favouritesViewController)
            let characterListViewController = CharacterListViewController()
            characterListViewController.tabBarItem = UITabBarItem(
                title: "Characters",
                image: UIImage(systemName: "person"),
                selectedImage: UIImage(systemName: "person.fill")
            )*/
            tabBarController.viewControllers = [
                navigationController
                //favouritesNavigationController,
                //characterListViewController
            ]
            // Asignamos el primer view controller
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
            self.window = window
            
    }

    

}

