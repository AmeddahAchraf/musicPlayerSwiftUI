import Foundation

protocol RequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var pathParameters: [String: String]? { get }
    var bodyParameters: [String: Any]? { get }
}

// MARK: GET Songs

struct FetchSongsRequest: RequestProtocol {
    let path = "search"
    let method: HTTPMethod = .POST
    let pathParameters: [String: String]? = nil
    let bodyParameters: [String: Any]?

    init(songType: SongType) {
        self.bodyParameters = [
            "search_queries": [
                [
                    "name": "tag_song",
                    "search_type": "tag_song",
                    "term": songType.rawValue,
                    "from_index": 0,
                    "rank_by": "most_relevant"
                ]
            ]
        ]
    }
}
