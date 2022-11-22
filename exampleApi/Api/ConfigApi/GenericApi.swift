//
//  GenericApi.swift
//  exampleApi
//
//  Created by Mauricio Guerrero on 22/11/22.
//

import Foundation

protocol Api {
    static var baseUrl: String { get }
}

protocol ApiEndpoint {
    static var queryUrl: String { get }
}
//
protocol ApiResponseDecodable {
    associatedtype T: Decodable
    func decodeResponse(_ data: Data) -> T?
    func decodeJSON(_ data: Data) -> T?
}
extension ApiResponseDecodable {
    func decodeJSON<T: Decodable>(_ data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

protocol URLProvider {
    var url: URL { get }
}
protocol ApiQuery: URLProvider {
    
    var method: HttpMethod { get }
    var data: Data? { get set }
    func getQueryItems() -> [ApiQueryItem]
}

extension ApiQuery {
    func getQueryItems() -> [ApiQueryItem] { [] }
}

typealias ApiQueryItem = URLQueryItem





protocol ApiQueryManager {
    func execute(_ query: ApiQuery, completionHandler: ((Data?) -> Void)?)
}
