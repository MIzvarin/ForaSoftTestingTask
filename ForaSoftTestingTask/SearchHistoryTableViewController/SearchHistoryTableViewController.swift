//
//  SearchHistoryTableViewController.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import UIKit

final class SearchHistoryTableViewController: UITableViewController {
    //MARK: - Static properties
    private static let cellIdentifier = "albumCell"
    
    //MARK: - Private properties
    private var albums: [Album] = []

    //MARK: - Overrided functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SearchHistoryTableViewController.cellIdentifier)
        setupNavBar(title: "History")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAlbum()
    }
    
    //MARK: - Private functions
    private func fetchAlbum() {
        StorageManager.shared.fetchObjects(type: Album.self) { [unowned self] albums in
            self.albums = albums
            self.tableView.reloadData()
        }
    }
    
    private func openDetailsVC(with album: Album) {
        let detailVC = AlbumDetailViewController(album: album)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - Extensions
//MARK: - Table view data source
extension SearchHistoryTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewController.cellIdentifier, for: indexPath as IndexPath)
        let album = albums[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = album.collectionName
        content.secondaryText = album.artistName
        cell.contentConfiguration = content
        
        guard let imageURL = album.artworkUrl60 else { return cell }
        ImageManager.shared.load(from: imageURL) { image in
            content.image = image
            cell.contentConfiguration = content
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailsVC(with: albums[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
