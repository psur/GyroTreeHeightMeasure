//
//  MeasureViewState.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 22.06.2024.
//

import Foundation

struct MeasureViewState {
    enum Status {
        case initial
    }
    
    var status: Status = .initial

    static let initial = MeasureViewState()
}
