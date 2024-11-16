import SwiftUI

struct SongRowView: View {
    var song: Song
    @Binding var isLiked: Bool

    var body: some View {
        HStack {
            // Thumbnail Image with overlay and play button
            ZStack {
                AsyncImage(url: URL(string: self.song.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(5)
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .frame(width: 80, height: 80)
                        .cornerRadius(5)
                }

                // Black overlay
                Color.black.opacity(0.1)
                    .frame(width: 80, height: 80)
                    .cornerRadius(5)

                // Play button
                Image(systemName: "play.circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .opacity(0.7)
            }

            // Song Information
            VStack(alignment: .leading) {
                Text(self.song.title)
                    .font(.headline)
                    .lineLimit(1)

                Text(self.song.displayName)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Play count: \(self.song.playCount)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: self.isLiked ? "heart.fill" : "heart")
                .foregroundColor(self.isLiked ? .pink : .gray.opacity(0.4))
                .onTapGesture {
                    self.isLiked.toggle()
                }
        }
        .padding(.vertical, 8)
    }
}

struct SongListView: View {
    var songType: SongType
    @EnvironmentObject var mediaPlayerState: MediaPlayerState
    @StateObject private var viewModel = SongViewModel()
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack {
            List(viewModel.songs, id: \.id) { song in
                SongRowView(song: song, isLiked: $isLiked)
                .onTapGesture {
                    mediaPlayerState.currentSong = song
                    mediaPlayerState.isMediaPlayerShown = true
                    mediaPlayerState.isMediaPlayerExpanded = true
                }
            }
            .listStyle(PlainListStyle())
        }
        .onAppear { viewModel.fetchSongs(songType: songType) }
        .navigationTitle("\(songType.rawValue) Mix")
        .navigationBarTitleDisplayMode(.large)
    }
}
