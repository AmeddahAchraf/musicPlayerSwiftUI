import Foundation

enum NetworkConfiguration: String {
    case debug
    case production

    var baseURL: String {
        switch self {
        case .debug:
            return "http://localhost:8080"
        case .production:
            return "https://studio-api.prod.suno.com/api/"
        }
    }

    static var current: NetworkConfiguration {
        #if DEBUG
        return .debug
        #else
        return .production
        #endif
    }
}
