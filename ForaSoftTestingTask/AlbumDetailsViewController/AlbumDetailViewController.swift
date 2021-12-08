//
//  AlbumDetailViewController.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import UIKit

final class AlbumDetailViewController: UIViewController {
    //MARK: Views
    private let imageView = UIImageView()
    private let artistAndAlbumNames: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let shortDescription: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    //MARK: - Private properties
    private let album: Album

    //MARK: - Overrided functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(title: "Album details")
        setupUI()
    }
    
    //MARK: - Init
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private functions
    private func setupUI() {
        view.backgroundColor = .white
        artistAndAlbumNames.text = "\(album.artistName) - \(album.collectionName)"
        shortDescription.text = album.shortDescription
        ImageManager.shared.load(from: album.artworkUrl60 ?? "") { [unowned self] image in
            self.imageView.image = image
        }
        
        view.addSubviews([artistAndAlbumNames, shortDescription, imageView])

        makeConstraints()
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerXWithinMargins.equalTo(view.snp_centerXWithinMargins)
        }
        
        artistAndAlbumNames.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(10)
            make.trailing.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        shortDescription.snp.makeConstraints { make in
            make.top.equalTo(artistAndAlbumNames.snp_bottomMargin).offset(10)
            make.trailing.leading.equalTo(10)
        }
    }
}

