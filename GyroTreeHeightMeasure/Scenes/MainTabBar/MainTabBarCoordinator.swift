//
//  MainTabBarCoordinator.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 21.06.2024.
//

import Combine
import os
import SwiftUI
import UIKit

final class MainTabBarCoordinator: NSObject, TabBarControllerCoordinator {
    var childCoordinators = [Coordinator]()
    private(set) lazy var tabBarController = makeTabBarController()
    private let eventSubject = PassthroughSubject<MainTabBarEvent, Never>()
    private lazy var cancellables = Set<AnyCancellable>()
    private let logger = Logger()
    
    deinit {
        logger.info("Deinit MainTabCoordinator")
    }
}

extension MainTabBarCoordinator {
    func start() {
        tabBarController.viewControllers = [
            setupMeasureView().rootViewController,
            setupProfileView().rootViewController
        ]
    }
}

private extension MainTabBarCoordinator {
    func makeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        tabBarItemAppearance.normal.iconColor = UIColor.systemGray
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        tabBarItemAppearance.selected.iconColor = UIColor.white
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

        tabBarController.tabBar.standardAppearance = tabBarAppearance
        tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBarController.delegate = self
        
        // Create a CAGradientLayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0, green: 100/255, blue: 0, alpha: 1).cgColor, // Dark Green
            UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1).cgColor // Light Green
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = tabBarController.tabBar.bounds
        
        // Render the gradient as an image
        if let gradientImage = getImageFrom(gradientLayer) {
            tabBarAppearance.backgroundImage = gradientImage
            tabBarController.tabBar.standardAppearance = tabBarAppearance
            tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
        return tabBarController
    }
    
    // Helper function to convert a CAGradientLayer to UIImage
    func getImageFrom(_ gradientLayer: CAGradientLayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, gradientLayer.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        gradientLayer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func setupMeasureView() -> ViewControllerCoordinator {
        let measureCoordinator = MeasureNavigationCoordinator()
        startChildCoordinator(measureCoordinator)
        measureCoordinator.eventPublisher
            .sink { [weak self] event in
                self?.handleEvent(event)
            }
            .store(in: &cancellables)
        measureCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Measure",
            image: UIImage(systemName: "list.bullet.rectangle.portrait"),
            tag: 0
        )
        return measureCoordinator
    }
    
    func setupProfileView() -> ViewControllerCoordinator {
        let profileCoordinator = ProfileNavigationCoordinator()
        startChildCoordinator(profileCoordinator)
        profileCoordinator.eventPublisher
            .sink { [weak self] event in
                self?.handleEvent(event)
            }
            .store(in: &cancellables)
        profileCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 0)
        
        return profileCoordinator
    }
}

extension MainTabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController === tabBarController.viewControllers?.last {
            // rootViewController.showInfoAlert(title: "Last view controller alert.")
        }
    }
}

// MARK: - Handling events
private extension MainTabBarCoordinator {
    func handleEvent(_ event: ProfileNavigationCoordinatorEvent) {
        switch event {
        default:
            break
        }
    }
    
    func handleEvent(_ event: MeasureNavigationCoordinatorEvent) {
        switch event {
        default:
            break
        }
    }
}

extension MainTabBarCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<MainTabBarEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
