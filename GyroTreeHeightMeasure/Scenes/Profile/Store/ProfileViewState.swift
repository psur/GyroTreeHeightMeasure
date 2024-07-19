//
//  ProfileViewState.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 24.06.2024.
//

import Foundation

struct ProfileViewState {
    enum Status {
        case initial
    }
    
    var status: Status = .initial

    static let initial = ProfileViewState()
}
