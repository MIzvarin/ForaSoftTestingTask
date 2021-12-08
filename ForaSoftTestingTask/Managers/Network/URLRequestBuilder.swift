//
//  URLRequestBuilder.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import Alamofire

//MARK: - URL Request Builder
protocol URLRequestBuilder: URLRequestConvertible {
    var baseURL: String { get }
    var parameters: Parameters? { get }
}

//MARK: - Extension URL Request Builder
extension URLRequestBuilder {
    var baseURL: String  {
        return URLs.baseURL.rawValue
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var request = URLRequest(url: url)
        
        request = try URLEncoding.default.encode(request, with: parameters)

        return request
    }
}

//MARK: - URLs
enum URLs: String {
    case baseURL = "https://itunes.apple.com/search"
}

