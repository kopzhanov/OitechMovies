import Foundation

class APIService {
    static let shared = APIService()
    
    private let apiKey = "c8747ea3b3mshcbb14eac6bcbcdbp142dcdjsncdd5e756ca3b"
    private let host = "movies-tv-shows-database.p.rapidapi.com"
    private let baseURL = "https://movies-tv-shows-database.p.rapidapi.com/"
    
    private init() {}
    
    func fetchTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return
        }
        urlComponents.queryItems = [URLQueryItem(name: "page", value: "1")]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(host, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue("get-trending-movies", forHTTPHeaderField: "Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    completion(.success(decoded.movie_results))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchMovieDetail(imdbID: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return
        }
        urlComponents.queryItems = [URLQueryItem(name: "movieid", value: imdbID)]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(host, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue("get-movie-details", forHTTPHeaderField: "Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(MovieDetail.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func searchMovie(title: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "title", value: title)]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(host, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue("get-movies-by-title", forHTTPHeaderField: "Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    completion(.success(decoded.movie_results))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
