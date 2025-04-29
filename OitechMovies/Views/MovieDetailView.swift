import UIKit
import SnapKit

class MovieDetailView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - UI Components

    let scrollView = UIScrollView()
    let contentView = UIView()

    let titleLabel = UILabel()
    let taglineLabel = UILabel()
    let yearLabel = UILabel()
    let ratingLabel = UILabel()
    let runtimeLabel = UILabel()
    let descriptionTitleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let actorsTitleLabel = UILabel()
    let actorsLabel = UILabel()

    var genres: [String] = []

    lazy var genresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        [titleLabel, taglineLabel, genresCollectionView, yearLabel, ratingLabel, runtimeLabel, descriptionTitleLabel, descriptionLabel, actorsTitleLabel, actorsLabel].forEach {
            contentView.addSubview($0)
        }

        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.numberOfLines = 0
        
        taglineLabel.font = .italicSystemFont(ofSize: 16)
        taglineLabel.numberOfLines = 2
        taglineLabel.textColor = .darkGray

        yearLabel.font = .systemFont(ofSize: 16)
        ratingLabel.font = .systemFont(ofSize: 16)
        descriptionTitleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 16)
        
        actorsTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        actorsLabel.font = UIFont.systemFont(ofSize: 17)
        actorsLabel.numberOfLines = 0

        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }

        taglineLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }

        genresCollectionView.snp.makeConstraints {
            $0.top.equalTo(taglineLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(32)
        }

        yearLabel.snp.makeConstraints {
            $0.top.equalTo(genresCollectionView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }

        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(yearLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }

        runtimeLabel.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }

        descriptionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(runtimeLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        actorsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }

        actorsLabel.snp.makeConstraints {
            $0.top.equalTo(actorsTitleLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-32)
        }
    }

    // MARK: - Public Method

    func configure(with movie: MovieDetail) {
        titleLabel.text = movie.title
        taglineLabel.text = movie.tagline
        yearLabel.text = "Year: \(movie.year)"
        ratingLabel.text = "IMDb Rating: \(movie.imdb_rating ?? "0")"
        descriptionTitleLabel.text = "Description"
        descriptionLabel.text = movie.description
        actorsTitleLabel.text = "Starring"
        let topActors = movie.stars?.prefix(10)
        actorsLabel.text = topActors?.joined(separator: "\n• ")
        actorsLabel.text = "• " + actorsLabel.text!

        genres = movie.genres ?? []
        genresCollectionView.reloadData()
    }

    // MARK: - Collection View DataSource & Delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: genres[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = genres[indexPath.item]
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width + 20
        return CGSize(width: width, height: 28)
    }
}
