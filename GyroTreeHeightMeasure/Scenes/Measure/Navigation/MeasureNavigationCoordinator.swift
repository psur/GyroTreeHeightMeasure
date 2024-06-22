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

protocol MeasureNavigationCoordinating {}

final class MeasureNavigationCoordinator: MeasureNavigationCoordinating {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    private lazy var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<MeasureNavigationCoordinatorEvent, Never>()
    private let logger = Logger()
    var childCoordinators = [Coordinator]()
    
    // MARK: Lifecycle
    deinit {
        logger.info("❌ Deinit ProfileNavigationCoordinator")
    }
    
    func start() {
        navigationController.setViewControllers([makeMeasureView()], animated: true)
    }
}

extension MeasureNavigationCoordinator {
    func makeMeasureView() -> UIViewController {
        return UIHostingController(rootView: MeasureView())
    }
}
