//
//  AlbumsCollectionViewController.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import UIKit

final class AlbumsCollectionViewController: UICollectionViewController {
    //MARK: Private properties
    private var albums: [Album] = []
    private let alertController: UIAlertController = {
        let alertController = UIAlertController(title: "Ooops!", message: "Something went wrong!😞", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        return alertController
    }()
    
    //MARK: - Properties for search
    private let searchController = UISearchController()
    private var filteredAlbums: [Album] = []
    var isSearchBarEmpty: Bool {
      searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltered: Bool {
      searchController.isActive && !isSearchBarEmpty
    }

    //MARK: - Overrided functions
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        self.collectionView!.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        loadAlbums()
        setupNavBar(title: "Search")
        setupSearchController()
    }
    
    //MARK: - Private functions
    private func loadAlbums() {
        NetworkManager.shared.load(from: AlbumsProvider(), decodeTo: Albums.self) { [unowned self] result in
            switch result {
            case .success(let albums):
                self.albums = albums.results.sorted { $0.collectionName < $1.collectionName } // Sorting data by alphabet
                collectionView.reloadData()
            case .error(let error):
                self.present(self.alertController, animated: true)
                print(error)
            }
        }
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search albums"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.addTarget(self,
                                                             action: #selector(openSearchResult),
                                                             for: .touchCancel)
    }
    
    @objc private func filterContentForSearchText() {
        let searchText = searchController.searchBar.text!
        filteredAlbums = albums.filter({$0.collectionName.lowercased().contains(searchText.lowercased())})
        collectionView.reloadData()
    }
    
    @objc private func openSearchResult() {
        guard isFiltered, !filteredAlbums.isEmpty else { return }
        openDetailsVC(with: filteredAlbums.first!)
    }
    
    private func openDetailsVC(with album: Album) {
        let detailVC = AlbumDetailViewController(album: album)
        navigationController?.pushViewController(detailVC, animated: true)
        guard isFiltered else { return }
        
        StorageManager.shared.saveEntity(album)
    }
}

//MARK: Extensions
//MARK: - UICollectionViewDataSource
extension AlbumsCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltered ? filteredAlbums.count : albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath)
        guard let albumCell = cell as? AlbumCollectionViewCell else { return cell }
        let album = isFiltered ? filteredAlbums[indexPath.row] : albums[indexPath.row]
        
        albumCell.configure(from: album)
        return albumCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = isFiltered ? filteredAlbums[indexPath.row] : albums[indexPath.row]
        openDetailsVC(with: album)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AlbumsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}

//MARK: - UISearchResultUpdating
extension AlbumsCollectionViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText()
    }
}

