//
//  PokemonListResponse.swift
//  Mentoria UIKit básico
//
//  Created by Rauls on 24/05/25.
//

struct PokemonListResponse: Decodable {
   let results: [PokemonResponse]
}

struct PokemonResponse: Decodable {
    let name: String
    let url: String

    func toDomainModel(indexPokemon: Int) -> Pokemon {
        return Pokemon(
            name: name,
            number: indexPokemon,
            pokemonImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(indexPokemon).png")
        
    }
}
