import UIKit

class PokemonCellView: UIView {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pokemonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(cardView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(numberLabel)
        cardView.addSubview(pokemonImage)
        NSLayoutConstraint.activate([

            
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),

            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),

            pokemonImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            pokemonImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            pokemonImage.heightAnchor.constraint(equalToConstant: 96),
            pokemonImage.widthAnchor.constraint(equalToConstant: 96),
            
        ])
    }
    
    public func configure(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name.capitalized
        numberLabel.text = "Número: \(pokemon.number)"
        pokemonImage.load(urlString: pokemon.pokemonImage)
    }
}
    

extension UIImageView {

    func load(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url){
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                            self.image = image
                    }
                }
            }
        }
    }
}

