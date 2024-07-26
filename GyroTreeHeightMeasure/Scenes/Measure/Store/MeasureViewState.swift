//
//  MeasureViewState.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 22.06.2024.
//

import Foundation

struct MeasureViewState {
    enum Status {
        case distanceMeasure
        case heightMeasure
    }
    
    var status: Status = .distanceMeasure

    static let distanceMeasure = MeasureViewState()
}
