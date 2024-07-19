//
//  CoordinatorView.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 21.06.2024.
//

import SwiftUI
import UIKit

struct CoordinatorView<T: ViewControllerCoordinator>: UIViewControllerRepresentable {
    let coordinator: T
    
    func makeUIViewController(context: Context) -> UIViewController {
        coordinator.rootViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
