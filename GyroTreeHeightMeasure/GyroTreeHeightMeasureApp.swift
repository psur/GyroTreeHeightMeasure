//
//  GyroTreeHeightMeasureApp.swift
//  GyroTreeHeightMeasure
//
//  Created by Peter Surovy on 19.05.2024.
//

import os
import SwiftUI

@main
struct GyroTreeHeightMeasureApp: App {
    @ObservedObject private var appCoordinator = AppCoordinator()
    private let logger = Logger()
    
    init() {
        appCoordinator.start()
    }
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: appCoordinator)
                .onAppear {
                    logger.info("🦈 AppCoordinator has appeared.")
                }
                .ignoresSafeArea(.all)
        }
    }
}
