//
//  Api.swift
//  exampleApi
//
//  Created by Mauricio Guerrero on 22/11/22.
//

import Foundation

struct ApiPokemon: Api {
    
    //Production
    static var baseUrl: String = "https://pokeapi.co/api/v2"
    
    //test
    //static var baseUrl : String = "https://pokeapi.co/api/v2/pokemon"
    
    
    private init() {}
}
