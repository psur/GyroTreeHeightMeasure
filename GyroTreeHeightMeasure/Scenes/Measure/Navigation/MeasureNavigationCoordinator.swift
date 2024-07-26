//
//  MeasureNavigationCoordinator.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 22.06.2024.
//

import Combine
import os
import SwiftUI
import UIKit

protocol MeasureNavigationCoordinating: NavigationControllerCoordinator {}

final class MeasureNavigationCoordinator: NSObject, MeasureNavigationCoordinating {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    private lazy var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<MeasureNavigationCoordinatorEvent, Never>()
    private let logger = Logger()
    var childCoordinators = [Coordinator]()
    
    // MARK: Lifecycle
    deinit {
        logger.info("❌ Deinit MeasureNavigationCoordinator")
    }
    
    func start() {
        let measureViewController = makeMeasureView()
        measureViewController.title = "Measure"
        navigationController.setViewControllers([measureViewController], animated: true)
    }
}

extension MeasureNavigationCoordinator {
    func makeMeasureView() -> UIViewController {
        let store = MeasureViewStore()
        store.eventPublisher
            .sink { [weak self] event in
                self?.handleEvent(event)
            }
            .store(in: &cancellables)
        return UIHostingController(rootView: MeasureDistanceView())
    }
}

extension MeasureNavigationCoordinator {
    func handleEvent(_ event: MeasureViewEvent) {
        switch event {
        case .finishedLengthMeasure:
            eventSubject.send(.finishedLengthMeasure)
        }
    }
}

extension MeasureNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<MeasureNavigationCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
