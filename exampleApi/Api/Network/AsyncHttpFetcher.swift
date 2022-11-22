//
//  AsyncHttpFetcher.swift
//  exampleApi
//
//  Created by Mauricio Guerrero on 22/11/22.
//

import Foundation


class AsyncHttpFetcher {
    
    func executeRequest(withUrl url: URL, completionHandler handler: (( Result<Data, URLRequestError>) -> Void)?) {
        let request = URLRequest(url: url)
        executeRequest(request, completionHandler: handler)
    }
    
    func executeRequest(_ request: URLRequest, completionHandler handler: (( Result<Data, URLRequestError>) -> Void)?) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in

            guard error == nil else {
                handler?(.failure(URLRequestError.request(RequestError(error: error!))))
                return
            }

            let httpResponse = response as! HTTPURLResponse

            // Request succeeded
            if httpResponse.statusCode == 200, let data = data {
                handler?(.success(data))
            } else {
                handler?(.failure(URLRequestError.http(NetworkRequestError(statusCode: httpResponse.statusCode))))
            }

        }
        
         task.resume()
    }
}
