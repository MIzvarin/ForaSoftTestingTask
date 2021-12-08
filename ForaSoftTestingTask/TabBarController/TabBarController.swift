//
//  TabBarController.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    //MARK: - Overrided functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
        tabBar.unselectedItemTintColor = .gray
        tabBar.barTintColor = .lightText
    }
    
    //MARK: - Private functions
    private func setupTabBarController() {
        let albumsCollectionVC = AlbumsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let albumsCollectionNavController = UINavigationController(rootViewController: albumsCollectionVC)
        let searchHistoryNavController = UINavigationController(rootViewController: SearchHistoryTableViewController())
        
        albumsCollectionNavController.title = "Search"
        albumsCollectionNavController.tabBarItem.image = UIImage(systemName: "music.note.list")
        
        searchHistoryNavController.title = "History"
        searchHistoryNavController.tabBarItem.image = UIImage(systemName: "doc.text.magnifyingglass")
        
        setViewControllers([albumsCollectionNavController, searchHistoryNavController], animated: false)
    }
}
