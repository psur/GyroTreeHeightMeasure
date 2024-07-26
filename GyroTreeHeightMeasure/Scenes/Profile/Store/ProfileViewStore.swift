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
    var state: ProfileViewState = .distanceMeasure
    var deviceHeight = 172.0
}

extension ProfileViewStore {
    func send(_ action: ProfileViewAction) {
        switch action {
        case .saveProfile(deviceHeight):
            saveToProfile()
        default:
            break
        }
    }
   
    func saveToProfile()
    {
        let defaults = UserDefaults.standard
        defaults.set(deviceHeight, forKey: "deviceHeight")
    }

        
}
