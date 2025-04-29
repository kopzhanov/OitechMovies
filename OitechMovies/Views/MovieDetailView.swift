import UIKit
import SnapKit

class MovieDetailView: UIView {
    
    // MARK: - UI Components

    let scrollView = UIScrollView()
    let contentView = UIView()

    let titleLabel = UILabel()
    let taglineLabel = UILabel()
    let yearLabel = UILabel()
    let ratingLabel = UILabel()
    let runtimeLabel = UILabel()
    let genresLabel = UILabel()
    let descriptionTitleLabel = UILabel()
    let descriptionLabel = UILabel()

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

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        [titleLabel, taglineLabel, yearLabel, ratingLabel, runtimeLabel, genresLabel, descriptionTitleLabel, descriptionLabel].forEach {
            $0.numberOfLines = 0
            contentView.addSubview($0)
        }

        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        taglineLabel.font = .italicSystemFont(ofSize: 16)
        taglineLabel.textColor = .darkGray

        yearLabel.font = .systemFont(ofSize: 16)
        ratingLabel.font = .systemFont(ofSize: 16)
        runtimeLabel.font = .systemFont(ofSize: 16)
        genresLabel.font = .systemFont(ofSize: 16)
        descriptionTitleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        descriptionLabel.font = .systemFont(ofSize: 16)

        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.right.equalToSuperview().inset(16)
        }

        taglineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }

        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(taglineLabel.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
        }

        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }

        runtimeLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }

        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(runtimeLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }

        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(genresLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    // MARK: - Public Method

    func configure(with movie: MovieDetail) {
        titleLabel.text = movie.title
        taglineLabel.text = movie.tagline.isEmpty ? "" : "\"\(movie.tagline)\""
        yearLabel.text = "Year: \(movie.year)"
        ratingLabel.text = "IMDb Rating ⭐️: \(movie.imdb_rating ?? "0"))"
        genresLabel.text = "Genres: \(movie.genres?.joined(separator: ", ") ?? "asd")"
        descriptionTitleLabel.text = "Description"
        descriptionLabel.text = movie.description
    }
}
