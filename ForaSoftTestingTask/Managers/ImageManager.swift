//
//  ImageManager.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import Alamofire

final class ImageManager {
    typealias LoadImageHandler = (UIImage?) -> Void
    
    //MARK: - Static properties
    static let shared = ImageManager()
    
    //MARK: - Private properties
    private let cache = URLCache.shared
    
    //MARK: - Public functions
    func load(from url: String, completion: @escaping LoadImageHandler) {
        guard let url = URL(string: url) else  { return }
        
        if let imageData = cache.cachedResponse(for: URLRequest(url: url))?.data { // Load data from cache
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                completion(image)
            }
        } else {                                                                    // Load data from network
            AF.request(url).responseData { response in
                guard let imageData = response.data,
                      let image = UIImage(data: imageData) else { return }
                DispatchQueue.main.async {
                    completion(image)
                }
                DispatchQueue.global().async {
                    let cachedData = CachedURLResponse(response: response.response!, data: imageData)
                    self.cache.storeCachedResponse(cachedData, for: response.request!)
                }
            }
        }
    }
    
    //MARK: - Init
    private init() {}
}

