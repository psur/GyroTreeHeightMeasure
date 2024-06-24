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
        
        appearance.backgroundColor = .systemBlue
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
//            NSAttributedString.Key.font: UIFont(name: <#T##String#>, size: <#T##CGFloat#>),
            NSAttributedString.Key.foregroundColor: UIColor(.white)
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
