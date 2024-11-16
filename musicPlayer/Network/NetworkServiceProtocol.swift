import Combine
import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        _ request: RequestProtocol
    ) -> AnyPublisher<T, Error>
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}
