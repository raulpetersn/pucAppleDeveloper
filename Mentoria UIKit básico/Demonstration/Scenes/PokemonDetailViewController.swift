//
//  PokemonService.swift
//  Mentoria UIKit básico
//
//  Created by Rauls on 29/05/25.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let pokemonDetailView = PokemonDetailView()
    private let pokemonName: String
    private let viewModel: PokemonDetailViewModel

    init(pokemonName: String) {
        self.pokemonName = pokemonName
        self.viewModel = PokemonDetailViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = pokemonDetailView
        bindViewModel()
        viewModel.fetchDetails(for: pokemonName)
    }

    private func bindViewModel() {
        viewModel.onDataLoaded = { [weak self] detail in
            self?.pokemonDetailView.configure(with: detail)
        }
        
        viewModel.onError = { errorMessage in
            print("Erro: \(errorMessage)")
        }
    }
}

