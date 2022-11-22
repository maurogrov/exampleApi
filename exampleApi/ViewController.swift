//
//  ViewController.swift
//  exampleApi
//
//  Created by Mauricio Guerrero on 22/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    typealias PokemonEndPoint = ApiPokemon.PokemonEndpoint
    let apiQueryManager = DefaultApiQueryManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getObtenerPokemon(name: "ditto")
    }
    
    func getObtenerPokemon(name: String){
        let query = PokemonEndPoint.GetObtenerPokemonByNameQuery(name: name)
        
        apiQueryManager.execute(query){ [weak self] (data) in
            guard let self = self else {return}
            
            if let data = data {
                if let response = query.decodeResponse(data){
                    print("model correct", response)
                    //self.messageAlert(mesagge: "success")
                }else {
                    //The model change
                    self.messageAlert(mesagge: "Error al codificar respuesta")
                }
            }else {
                //show to present
                self.messageAlert(mesagge: "error")
            }
        }
        
    }
    func messageAlert(mesagge: String){
        print(mesagge)
    }


}

