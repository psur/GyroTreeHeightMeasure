//
//  ProfileNavigationCoordinator.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 21.06.2024.
//

import Combine
import os
import SwiftUI
import UIKit

protocol ProfileCoordinating: NavigationControllerCoordinator {}

final class ProfileNavigationCoordinator: NSObject, ProfileCoordinating {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    private lazy var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<ProfileNavigationCoordinatorEvent, Never>()
    private let logger = Logger()
    var childCoordinators = [Coordinator]()
    
    // MARK: Lifecycle
    deinit {
        logger.info("❌ Deinit ProfileNavigationCoordinator")
    }
    
    func start() {
        navigationController.setViewControllers([makeProfile()], animated: true)
    }
}

// MARK: - Factories
private extension ProfileNavigationCoordinator {
    func makeProfile() -> UIViewController {
        
        return UIHostingController(rootView: ProfileView())
    }
}

private extension ProfileNavigationCoordinator {
    func handleEvent(_ event: ProfileViewEvent) {
        switch event {
        default:
            break
        }
    }
}

extension ProfileNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<ProfileNavigationCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
