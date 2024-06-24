//
//  MeasureViewStore.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 22.06.2024.
//

import Combine
import Foundation
import os

@Observable final class MeasureViewStore: ObservableObject, Store {
    private let logger = Logger()
    private let eventSubject = PassthroughSubject<MeasureViewEvent, Never>()
    var eventPublisher: AnyPublisher<MeasureViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    var state: MeasureViewState = .initial
    struct DeviceOrientation {
        var orientationX: Double = 0.0
        var orientationY: Double = 0.0
        var orientationZ: Double = 0.0
    }
    
    var deviceOrientation = DeviceOrientation(orientationX: 0, orientationY: 0, orientationZ: 0)
    var distance: Double = 0.0
    var savedOrientationZ: Double = 0.0
    
}

extension MeasureViewStore {
    func send(_ action: MeasureViewAction) {
        switch action {
        case .startMeasure:
            break
        }
    }
}
