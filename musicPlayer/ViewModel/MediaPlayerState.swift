import SwiftUI

final class MediaPlayerState: ObservableObject {
    @Published var isMediaPlayerShown: Bool = false
    @Published var isMediaPlayerExpanded: Bool = false
    @Published var currentSong: Song = .init(id: "1", videoURL: "", audioURL: "", imageURL: "", imageLargeURL: "h", isVideoPending: false, majorModelVersion: "", modelName: "", isLiked: true, userID: "", displayName: "", handle: "", isHandleUpdated: false, avatarImageURL: "", isTrashed: false, createdAt: "", status: "", title: "", playCount: 0, upvoteCount: 0, isPublic: true)
}
