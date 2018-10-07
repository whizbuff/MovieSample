//
//  AppDelegate.swift
//  MovieSample
//
//  Created by rajesh.rao on 06/10/2018.
//  Copyright © 2018 rajesh.rao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = MovieListViewController.init(nibName: "MovieListViewController", bundle: nil)
        let navigationController = UINavigationController.init(rootViewController: viewController)
        navigationController.navigationBar.barStyle = .black
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        return true
    }
}
