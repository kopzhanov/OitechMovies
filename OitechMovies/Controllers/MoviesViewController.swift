import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    private let tableView = UITableView()
    private var movies: [Movie] = []
    
    private let headerStack = UIStackView()
    private let titleLabel = UILabel()
    private let searchButton = UIButton(type: .system)
    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Trending Movies"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)

        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)

        headerStack.axis = .horizontal
        headerStack.spacing = 10
        headerStack.alignment = .center
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(searchButton)

        searchBar.placeholder = "Search for a movie"
        searchBar.delegate = self
        searchBar.isHidden = true

        view.addSubview(headerStack)
        view.addSubview(searchBar)
        view.backgroundColor = .white
        setupTableView()
        fetchMovies()
    }
    
    @objc private func didTapSearch() {
        searchBar.isHidden.toggle()
        searchBar.becomeFirstResponder()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        headerStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
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
        let detailVC = MovieDetailViewController(imdbID: movie.imdbID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }

        print(text)
        APIService.shared.searchMovie(title: text) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Search error: \(error.localizedDescription)")
                }
            }
        }

        searchBar.resignFirstResponder()
    }
}
