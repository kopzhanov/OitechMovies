import UIKit

class MovieDetailViewController: UIViewController {
    private let imdbID: String
    private let detailView = MovieDetailView()

    init(imdbID: String) {
        self.imdbID = imdbID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(detailView)
        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        fetchDetail()
    }

    private func fetchDetail() {
        APIService.shared.fetchMovieDetail(imdbID: imdbID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetail):
                    self?.detailView.configure(with: movieDetail)
                case .failure(let error):
                    print("Failed to load details: \(error)")
                }
            }
        }
    }
}
