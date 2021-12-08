//
//  NetworkManager.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import Alamofire

//MARK: - Network manager
class NetworkManager {
    static let shared = NetworkManager()
    
    func load<T: URLRequestBuilder ,U: Codable>(from source: T, decodeTo: U.Type, completion: @escaping((Result<U>) -> Void)) {
        guard let request = source.urlRequest else { return }
        
        AF.request(request).responseDecodable(of: U.self) { result in
            switch result.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
}

//MARK: - Result
enum Result<T: Codable> {
    case success(T)
    case error(Error)
}
