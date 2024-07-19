//
//  ProfileViewStore.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 24.06.2024.
//

import Combine
import Foundation
import os
import SwiftUI

@Observable final class ProfileViewStore: ObservableObject, Store {
    private let logger = Logger()
    private let eventSubject = PassthroughSubject<ProfileViewEvent, Never>()
    var eventPublisher: AnyPublisher<ProfileViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    var state: ProfileViewState = .initial
    var height = 172.0
}

extension ProfileViewStore {
    func send(_ action: ProfileViewAction) {
        switch action {
        default:
            break
        }
    }
}
