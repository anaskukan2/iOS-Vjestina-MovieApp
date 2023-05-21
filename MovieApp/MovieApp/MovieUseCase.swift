import Foundation

class MoviesUseCase {
    private let baseURL = "https://five-ios-api.herokuapp.com"
    private let apiKey = "Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps"
    
    func getFreeToWatchMovies(criteria: String) async throws -> [Movie] {
        let request = try createRequest(for: "/api/v1/movie/free-to-watch", criteria: criteria)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Movie].self, from: data)
    }
    
    func getPopularMovies(criteria: String) async throws -> [Movie] {
        let request = try createRequest(for: "/api/v1/movie/popular", criteria: criteria)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Movie].self, from: data)
    }
    
    func getTrendingMovies(criteria: String) async throws -> [Movie] {
        let request = try createRequest(for: "/api/v1/movie/trending", criteria: criteria)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Movie].self, from: data)
    }
    
    func getMovieDetails(id: Int) async throws -> MovieDetails {
        let request = try createRequest(for: "/api/v1/movie/details", id: id)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(MovieDetails.self, from: data)
    }
    
    private func createRequest(for path: String, criteria: String) throws -> URLRequest {
        let urlString = "\(baseURL)\(path)?criteria=\(criteria)"
        return try createRequest(for: urlString)
    }
    
    private func createRequest(for path: String, id: Int) throws -> URLRequest {
        let urlString = "\(baseURL)\(path)/\(id)"
        return try createRequest(for: urlString)
    }
    
    private func createRequest(for urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
