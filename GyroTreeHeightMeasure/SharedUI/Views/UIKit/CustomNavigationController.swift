//
//  CustomNavigationController.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 21.06.2024.
//

import Combine
import os
import UIKit

class CustomNavigationController: UINavigationController {
    private let logger = Logger()
    private let eventSubject = PassthroughSubject<CustomNavigationControllerEvent, Never>()
    private var isSwipingBack = false
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed {
            eventSubject.send(.dismiss)
        }
    }
}

// MARK: - EventEmitting
extension CustomNavigationController: EventEmitting {
    var eventPublisher: AnyPublisher<CustomNavigationControllerEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
