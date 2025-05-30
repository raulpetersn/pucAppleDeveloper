import UIKit

class PokemonListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var pokemonList: [Pokemon] = []
    var pokemonDetail: PokemonDetail? = nil
    let url = "https://pokeapi.co/api/v2/pokemon?limit=150&offset=0"
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 150
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        view.addSubview(tableView)
        fecthPokemonList()
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fecthPokemonList() {
        guard let fakeUlr = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: fakeUlr) { data, _, error in
            guard let data, error == nil else { return }
        
            do {
                let decode = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                let decodedList = decode.results.enumerated().map { index, pokemon in
                    pokemon.toDomainModel(indexPokemon: index + 1)
                }
                
                DispatchQueue.main.async {
                    self.pokemonList = decodedList
                    self.tableView.reloadData()
                }
            } catch {
                print("Error no request \(error)")
            }
            
        }.resume()
    }
    
    @objc
    func goToPokemonDetails(pokemonName: String) {
        navigationController?.pushViewController(PokemonDetailViewController(pokemonName: pokemonName), animated: true)
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: pokemonList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokemonList[indexPath.row].name
        return goToPokemonDetails(pokemonName: selectedPokemon)
    }
}




