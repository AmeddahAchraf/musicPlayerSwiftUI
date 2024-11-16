import Combine
import Foundation

final class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()

    private init() {}

    private var defaultHeaders: [String: String] {
        // TODO: INSERT YOUR TOKEN IN THE BEARER
        [
            "Authorization": "Bearer INSERT YOUT TOKEN HERE",
            "Content-Type": "text/plain; charset=utf-8"
        ]
    }

    func request<T: Decodable>(
        _ request: RequestProtocol
    ) -> AnyPublisher<T, Error> {
        guard var url = URL(string: NetworkConfiguration.current.baseURL) else {
            fatalError("Error creating base URL")
        }

        var resolvedPath = request.path
        if let pathParameters = request.pathParameters {
            for (key, value) in pathParameters {
                resolvedPath = resolvedPath.replacingOccurrences(of: "{\(key)}", with: value)
            }
        }

        url.appendPathComponent(resolvedPath)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        defaultHeaders.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }

        if let parameters = request.bodyParameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
