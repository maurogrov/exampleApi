//
//  DefaultApiQueryManager.swift
//  exampleApi
//
//  Created by Mauricio Guerrero on 22/11/22.
//

import Foundation

class DefaultApiQueryManager: NSObject, ApiQueryManager {
    
    func execute(_ query: ApiQuery, completionHandler: ((Data?) -> Void)? = nil) {
        let request: URLRequest
        switch query.method {
        case .get:
            request = composeGetRequest(for: query)
        case .put:
            request = composePutRequest(for: query)
        case .post:
            request = composePostRequest(for: query)
        default:
            fatalError("No hay un comportamiento definido para el método: \(query.method)")
        }
        execute(request, for: query, completionHandler: completionHandler)
    }
    
    
    private func execute(_ request: URLRequest, for query: ApiQuery, completionHandler: ((Data?) -> Void)?) {
        let asyncFetcher = AsyncHttpFetcher()
        asyncFetcher.executeRequest(request) { result in
            switch result {
            case .success(let data):
                completionHandler?(data)
            case .failure(let error):
                let errorDesc: String
                switch error {
                case .http(let httpError):
                    errorDesc = httpError.localizedDescription
                case .request(let reqError):
                    errorDesc = reqError.localizedDescription
                }
                print(errorDesc)
                debugPrint(request)
                completionHandler?(nil)
            }
        }
    }
    
    private func composePutRequest(for query: ApiQuery) -> URLRequest {
        var url = query.url
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems = query.getQueryItems()
        components.queryItems = queryItems
        url = components.url!
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.put.rawValue
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        request.httpBody = query.data
        
        return request
    }
    
    private func composePostRequest(for query: ApiQuery) -> URLRequest {
        var url = query.url
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems = query.getQueryItems()
        components.queryItems = queryItems
        url = components.url!
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post.rawValue
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        request.httpBody = query.data
        
        return request
    }
    
    private func composeGetRequest(for query: ApiQuery) -> URLRequest {
        var urlComponents = URLComponents(url: query.url, resolvingAgainstBaseURL: true)!
        let queryItems = query.getQueryItems()
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        
        //remove the items in the api
        let newURL = URL(string: url.absoluteString.replacingOccurrences(of: "?=", with: ""))
        
        var request = URLRequest(url: newURL!)
        
        // Setup request
        request.httpMethod = HttpMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
}
