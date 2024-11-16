import SwiftUI

struct TabBarView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }

    @EnvironmentObject var mediaPlayerState: MediaPlayerState

    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .environmentObject(mediaPlayerState)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                PlaylistView()
                    .tabItem {
                        Label("Playlist", systemImage: "music.note.list")
                    }
                LibraryView()
                    .tabItem {
                        Label("Library", systemImage: "books.vertical")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
            .accentColor(.purple)
            
            if mediaPlayerState.isMediaPlayerShown {
                VStack {

                    SongView()
                        .frame(height: mediaPlayerState.isMediaPlayerExpanded ? nil : 60)
                        .cornerRadius(mediaPlayerState.isMediaPlayerExpanded ? 40 : 15)
                        .padding(.horizontal, mediaPlayerState.isMediaPlayerExpanded ? 0 : 5)
                        .padding(.bottom, mediaPlayerState.isMediaPlayerExpanded ? -20 : 40)
                        .padding(.top, mediaPlayerState.isMediaPlayerExpanded ? 60 : 40)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mediaPlayerState.isMediaPlayerExpanded.toggle()
                            }
                        }
                        .environmentObject(mediaPlayerState)
                }
                .frame(maxHeight: .infinity, alignment: mediaPlayerState.isMediaPlayerExpanded ? .top : .bottom)
                .padding(.bottom)
                .ignoresSafeArea(edges: mediaPlayerState.isMediaPlayerExpanded ? .all : .top)
            }
        }
    }
}

struct PlaylistView: View {
    var body: some View {
        VStack {
            Text("Playlist")
                .font(.largeTitle)
        }
    }
}

struct LibraryView: View {
    var body: some View {
        VStack {
            Text("Library")
                .font(.largeTitle)
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
        }
    }
}

#Preview(body: {
    TabBarView()
        .environmentObject(MediaPlayerState())
})
