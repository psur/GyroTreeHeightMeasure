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
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = .none
        
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.delegate = self
        return tabBarController
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
