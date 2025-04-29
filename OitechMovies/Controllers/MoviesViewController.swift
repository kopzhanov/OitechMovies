import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trending Movies"
        view.backgroundColor = .white
        setupTableView()
        fetchMovies()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func fetchMovies() {
        APIService.shared.fetchTrendingMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let detailVC = MovieDetailViewController(imdbID: movie.imdb_id)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
