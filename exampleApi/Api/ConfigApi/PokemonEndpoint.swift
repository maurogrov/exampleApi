//
//  PokemonEndpoint.swift
//  exampleApi
//
//  Created by Mauricio Guerrero on 22/11/22.
//

import Foundation

extension ApiPokemon {
    
    //by each api create a new Structure
    // /getPokemonByName
    // /getPokemonByID
    
    
    // MARK: - PokemonByName
    struct PokemonEndpoint: ApiEndpoint {
        static let queryUrl: String = "\(baseUrl)/pokemon"
        
        private init() {}
        
        // MARK: - GetObtenerByName
        struct GetObtenerPokemonByNameQuery: ApiQuery, ApiResponseDecodable {
                        
            var url: URL = URL(string: "\(PokemonEndpoint.queryUrl)/")!
            
        
            var method: HttpMethod = .get
            var data: Data?
            
            let name: String
            
            //urlchange this style with params = ?name=ditto
            func getQueryItems() -> [ApiQueryItem] {
                [
                    ApiQueryItem(name: "", value: name)
                ]
            }
            
            func decodeResponse(_ data: Data) -> Pokemon? {
                decodeJSON(data)
            }
        }
        
    }
    
}
