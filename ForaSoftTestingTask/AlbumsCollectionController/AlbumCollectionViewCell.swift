//
//  AlbumCollectionViewCell.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import SnapKit

final class AlbumCollectionViewCell: UICollectionViewCell {
    //MARK: Static properties
    static let identifier = "AlbumCollectionViewCell"

    //MARK: - Views
    private let albumName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    //MARK: - Private properties
    private let imageView = UIImageView()
    
    //MARK: - Overrided functions
    override func layoutSubviews() {
        contentView.addSubviews([albumName, imageView])
        
        imageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.height.equalTo(contentView.frame.height)
        }
        
        albumName.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp_trailingMargin).offset(20)
            make.trailing.top.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Public functions
    func configure(from album: Album) {
        albumName.text = album.collectionName
        
        guard let imageURL = album.artworkUrl60 else { return }
        ImageManager.shared.load(from: imageURL) { [unowned self] image in
            self.imageView.image = image
        }
    }
}
