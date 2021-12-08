//
//  Extensions.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import UIKit

//MARK: - UIViewController
extension UIViewController {
    func setupNavBar(title: String) {
        let navBarAppearance = UINavigationBarAppearance()
        let backgroundColor = UIColor.systemTeal
        
        let textColor = UIColor.white
        let font = UIFont.boldSystemFont(ofSize: 24)
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: textColor, .font: font]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]
        navBarAppearance.backgroundColor = backgroundColor
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = title
    }
}

//MARK: - UIView
extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
