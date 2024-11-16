import Foundation

struct ApiResponse: Codable {
    let result: ResultData
}

struct ResultData: Codable {
    let tagSong: TagSongData

    enum CodingKeys: String, CodingKey {
        case tagSong = "tag_song"
    }
}

struct TagSongData: Codable {
    let totalHits: Int
    let result: [Song]

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
        case result
    }
}

struct Song: Codable {
    let id: String
    let videoURL: String
    let audioURL: String
    let imageURL: String
    let imageLargeURL: String
    let isVideoPending: Bool
    let majorModelVersion: String
    let modelName: String
    var isLiked: Bool
    let userID: String
    let displayName: String
    let handle: String
    let isHandleUpdated: Bool
    let avatarImageURL: String
    let isTrashed: Bool
    let createdAt: String
    let status: String
    let title: String
    let playCount: Int
    let upvoteCount: Int
    let isPublic: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case videoURL = "video_url"
        case audioURL = "audio_url"
        case imageURL = "image_url"
        case imageLargeURL = "image_large_url"
        case isVideoPending = "is_video_pending"
        case majorModelVersion = "major_model_version"
        case modelName = "model_name"
        case isLiked = "is_liked"
        case userID = "user_id"
        case displayName = "display_name"
        case handle
        case isHandleUpdated = "is_handle_updated"
        case avatarImageURL = "avatar_image_url"
        case isTrashed = "is_trashed"
        case createdAt = "created_at"
        case status
        case title
        case playCount = "play_count"
        case upvoteCount = "upvote_count"
        case isPublic = "is_public"
    }
}

struct Metadata: Codable {
    let tags: String
    let prompt: String
    let type: String
    let duration: Double
}
