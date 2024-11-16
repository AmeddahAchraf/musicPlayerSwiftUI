import AVFoundation
import Combine

class AudioPlayer: ObservableObject {
    private var player: AVPlayer?
    private var timeObserverToken: Any?
    private var currentURL: URL?
    
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var isPlaying: Bool = false
    @Published var isAudioLoaded: Bool = false
    
    private var cancellables = Set<AnyCancellable>()

    func loadAudio(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        // Check if the audio is already loaded and playing the same URL
        if isAudioLoaded, url == currentURL, isPlaying {
            return // Don't reload if it's already playing the same URL
        }
        
        currentURL = url
        
        // Attempt to load from cache if available
        if let cachedURL = getCachedAudioURL(for: url) {
            setupPlayer(with: cachedURL)
        } else {
            // If not in cache, download and cache it
            downloadAndCacheAudio(from: url)
        }
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func togglePlayback() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func seek(to time: Double) {
        player?.seek(to: CMTime(seconds: time, preferredTimescale: 1))
    }
    
    private func setupPlayer(with url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        // Observe when audio is ready
        playerItem.publisher(for: \.status)
            .sink { [weak self] status in
                if status == .readyToPlay {
                    self?.duration = playerItem.duration.seconds
                    self?.isAudioLoaded = true
                }
            }
            .store(in: &cancellables)
        
        addPeriodicTimeObserver()
        play()
    }
    
    private func downloadAndCacheAudio(from url: URL) {
        URLSession.shared.downloadTask(with: url) { [weak self] localURL, _, error in
            guard let self = self, let localURL = localURL, error == nil else { return }
            let cacheURL = self.getCacheURL(for: url)
            
            do {
                try FileManager.default.moveItem(at: localURL, to: cacheURL)
                DispatchQueue.main.async {
                    self.setupPlayer(with: cacheURL)
                }
            } catch {
                print("Error caching audio file:", error)
            }
        }.resume()
    }
    
    private func getCacheURL(for url: URL) -> URL {
        let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        return cacheDir.appendingPathComponent(url.lastPathComponent)
    }
    
    private func getCachedAudioURL(for url: URL) -> URL? {
        let cacheURL = getCacheURL(for: url)
        return FileManager.default.fileExists(atPath: cacheURL.path) ? cacheURL : nil
    }
    
    private func addPeriodicTimeObserver() {
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] time in
            self?.currentTime = time.seconds
        }
    }
    
    deinit {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
        }
    }
}
