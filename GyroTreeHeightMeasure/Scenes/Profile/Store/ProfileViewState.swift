//
//  ProfileViewState.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 24.06.2024.
//

import Foundation

struct ProfileViewState {
    enum Status {
        case distanceMeasure
    }
    
    var status: Status = .distanceMeasure

    static let distanceMeasure = ProfileViewState()
}
