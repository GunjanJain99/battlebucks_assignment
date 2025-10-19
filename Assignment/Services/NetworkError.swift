
import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case statusCode(Int)
    case decodingError(Error)
    case other(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .statusCode(let code): return "Server returned status code \(code)."
        case .decodingError(let err): return "Decoding error: \(err.localizedDescription)"
        case .other(let err): return err.localizedDescription
        }
    }
}

final class NetworkService {
    static let shared = NetworkService()
    private init() {}

    func fetchPosts(completion: @escaping (Result<[Post], NetworkError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }

            if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
                completion(.failure(.statusCode(http.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.other(NSError(domain: "", code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "No data"]))))
                return
            }

            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
