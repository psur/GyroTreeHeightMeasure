//
//  UINavigationController+Ext.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 21.06.2024.
//

import UIKit

extension UINavigationController {
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .systemGreen
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24),
            NSAttributedString.Key.foregroundColor: UIColor(.white)
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}

