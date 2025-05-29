//
//  PokemonDetailsResponse.swift
//  Mentoria UIKit básico
//
//  Created by Rauls on 29/05/25.
//

struct PokemonDetailsResponse: Decodable {
    
    let idPokemon: Int
    let weight: Int
    let height: Int
    
    enum CodingKey: String, Codable {
    case idPokemon = "id"
    case weight = "weight"
    case height = "height"
    }
    
}
