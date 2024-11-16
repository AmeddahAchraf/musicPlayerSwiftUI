import SwiftUI

import SwiftUI

struct SongTypeView: View {
    var title: String
    var imageName: String

    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(20)

            Color.black.opacity(0.4)
                .cornerRadius(20)

            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .rotationEffect(.degrees(-10))
        }
        .frame(width: 150, height: 150)
        .cornerRadius(20)
    }
}

struct SongTypesListView: View {
    @EnvironmentObject var mediaPlayerState: MediaPlayerState
    
    var body: some View {
        VStack(spacing: 100) {
            VStack(alignment: .leading) {
                Text("Today’s Biggest Hits")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(SongType.allCases, id: \.self) { songType in
                            NavigationLink(destination: SongListView(songType: songType).environmentObject(mediaPlayerState)) {
                                SongTypeView(title: songType.rawValue, imageName: songType.rawValue)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Trending Genres")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(SongType.allCases.reversed(), id: \.self) { songType in
                            NavigationLink(destination: SongListView(songType: songType).environmentObject(mediaPlayerState)) {
                                SongTypeView(title: songType.rawValue, imageName: songType.rawValue)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
    
        }
    }
}

struct HomeView: View {
    @EnvironmentObject var mediaPlayerState: MediaPlayerState
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.3)
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    SongTypesListView()
                        .environmentObject(mediaPlayerState)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .accentColor(.red)
    }
}

