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
}

extension MeasureViewStore {
    func send(_ action: MeasureViewAction) {
        switch action {
        case .startMeasure:
            break
        }
    }
}
