//
//  ViewControllerCoordinator.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 21.06.2024.
//

import UIKit

protocol ViewControllerCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
    func showError(_ error: CustomError)
}

extension ViewControllerCoordinator {
    func showError(_ error: CustomError) {
        rootViewController.showInfoAlert(
            title: "Error",
            message: error.localizedDescription
        )
    }
}
