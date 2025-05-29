import UIKit

class PokemonDetailView: UIView {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        return view
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    id: 54,
//    name: "Psyduck",
//    height: 0.8,
//    weight: 19.6,
//    types: [.water],
//    imageUrl: "psyduck"
    
    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    lazy var idLabel: UILabel = {
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                idLabel,
                weightLabel,
                heightLabel,
                typeLabel,
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
//        self.backgroundColor = Colors.gray600
        addSubview(nameLabel)
        addSubview(stackView)
        addSubview(contentView)
        addSubview(bottomView)
        addSubview(pokemonImage)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            contentView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pokemonImage.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            pokemonImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pokemonImage.widthAnchor.constraint(equalToConstant: 164),
            pokemonImage.heightAnchor.constraint(equalToConstant: 164),
            
            stackView.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configure(with pokemonDetail: PokemonDetail) {
        let typesText = pokemonDetail.types.map { $0.getTitle() }.joined(separator: ", ")
        guard let pokemonColor = pokemonDetail.types.first?.getColor() else { return }
        nameLabel.text = pokemonDetail.name
        idLabel.text = "ID: \(pokemonDetail.id)"
        heightLabel.text = "Altura: \(pokemonDetail.height)"
        weightLabel.text = "Peso: \(pokemonDetail.weight)"
        typeLabel.text = "Tipo: \(typesText)"
        pokemonImage.image = UIImage(named: pokemonDetail.imageUrl)
        
        setupBackgroundColor(color: pokemonColor)
    }
    
    func setupBackgroundColor(color: UIColor){
        self.backgroundColor = color
    }
}
