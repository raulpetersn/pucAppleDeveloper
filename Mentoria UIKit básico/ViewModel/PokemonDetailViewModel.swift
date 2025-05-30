//
//  PokemonDetailViewModel.swift
//  Mentoria UIKit básico
//
//  Created by Rauls on 29/05/25.
//

import Foundation
import UIKit

final class PokemonDetailViewModel {
    
    private let service: PokemonServiceProtocol
    private(set) var pokemonDetail: PokemonDetail?
    
    var onDataLoaded: ((PokemonDetail) -> Void)?
    var onError: ((String) -> Void)?
    
    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
    }
    
    func fetchDetails(for name: String) {
        service.fetchDetails(for: name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detail):
                    self?.pokemonDetail = detail
                    self?.onDataLoaded?(detail)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}
