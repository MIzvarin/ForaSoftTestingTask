//
//  AlbumsProvider.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import Alamofire

struct AlbumsProvider: URLRequestBuilder {
    
    var parameters: Parameters? {
        return ["term": "rock",
                "country": "US",
                "media": "music",
                "entity": "album"]
    }
}
