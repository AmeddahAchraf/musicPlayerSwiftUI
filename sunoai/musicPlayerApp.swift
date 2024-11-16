import SwiftUI

@main
struct musicPlayerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var mediaPlayerState = MediaPlayerState()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(mediaPlayerState)
        }
    }
}
