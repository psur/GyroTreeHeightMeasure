//
//  AppCoordinator.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 21.06.2024.
//

import Combine
import os
import UIKit

protocol AppCoordinating: ViewControllerCoordinator {}

final class AppCoordinator: AppCoordinating, ObservableObject {
    private(set) lazy var rootViewController: UIViewController = {
        makeTabBarFlow().rootViewController
    }()
    var childCoordinators = [Coordinator]()
    private lazy var cancellables = Set<AnyCancellable>()
    private lazy var logger = Logger()
    
    // MARK: Lifecycle
    init() {
    }
}

extension AppCoordinator {
    func start() {
        setupAppUI()
    }
    
    func setupAppUI() {
        UITabBar.appearance().backgroundColor = .systemBrown
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .white
//        UITabBarItem.appearance().setTitleTextAttributes(
//            [
//                NSAttributedString.Key.font: TextType.caption.uiFont
//            ], for: .normal
//        )
        UINavigationBar.appearance().tintColor = .white
    }
    
    func makeTabBarFlow() -> ViewControllerCoordinator {
        let mainTabBarCoordinator = MainTabBarCoordinator()
        startChildCoordinator(mainTabBarCoordinator)
        mainTabBarCoordinator.eventPublisher.sink { [weak self] event in
            self?.handleEvent(event)
        }
        .store(in: &cancellables)
        return mainTabBarCoordinator
    }
}

extension AppCoordinator {
    func handleEvent(_ event: MainTabBarEvent) {
        switch event {
        default:
            break
        }
    }
}
