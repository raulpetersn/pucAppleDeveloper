//
//  PokemonDetailsResponse.swift
//  Mentoria UIKit básico
//
//  Created by Rauls on 29/05/25.
//

struct PokemonDetailsResponse: Decodable {
    
    let id: Int
    let weight: Double
    let height: Double
    let name: String
    let types: [PokemonTypeEntry]
    let sprites: PokemonSprites
}

struct PokemonTypeEntry: Decodable {
    let slot: Double
    let type: PokemonTypeWithSprites
}

struct PokemonTypeWithSprites: Codable {
    let name: String
    let url: String
}

struct PokemonSprites: Decodable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
