//
//  Albums.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import RealmSwift

//MARK: - Albums
struct Albums: Codable {
    let results: [Album]
}

//MARK: Album
class Album: Object, Codable {
    @objc dynamic var artistName: String = ""
    @objc dynamic var collectionName: String = ""
    @objc dynamic var collectionExplicitness: String = ""
    @objc dynamic var trackCount: Int = 0
    @objc dynamic var copyright: String = ""
    @objc dynamic var primaryGenreName: String = ""
    @objc dynamic var artworkUrl60: String?
    
    override class func primaryKey() -> String? {
        return "collectionName"
    }
    
    var shortDescription: String {
        """
        Track count: \(trackCount)
        Genre: \(primaryGenreName)
        Copyright: \(copyright)
        """
    }
}
