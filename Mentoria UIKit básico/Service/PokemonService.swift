//
//  PokemonService.swift
//  Mentoria UIKit básico
//
//  Created by Rauls on 29/05/25.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchDetails(for name: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
}

final class PokemonService: PokemonServiceProtocol {
    
    private let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    func fetchDetails(for name: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        guard let url = URL(string: baseURL + name) else {
            return completion(.failure(NSError(domain: "URL inválida", code: 0)))
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data else {
                return completion(.failure(NSError(domain: "Sem dados", code: 0)))
            }
            
            do {
                let decoded = try JSONDecoder().decode(PokemonDetailsResponse.self, from: data)
                let typeName = decoded.types.first?.type.name ?? ""
                let domainModel = PokemonDetail(
                    id: decoded.id,
                    name: decoded.name.capitalized,
                    height: decoded.height,
                    weight: decoded.weight,
                    types: PokemonType(rawValue: typeName) ?? .normal,
                    imageUrl: decoded.sprites.frontDefault
                )

                completion(.success(domainModel))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
