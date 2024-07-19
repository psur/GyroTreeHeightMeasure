//
//  TabBarControllerCoordinator.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 21.06.2024.
//

import UIKit

protocol TabBarControllerCoordinator: ViewControllerCoordinator {
    var tabBarController: UITabBarController { get }
}

extension TabBarControllerCoordinator {
    var rootViewController: UIViewController {
        tabBarController
    }
}
