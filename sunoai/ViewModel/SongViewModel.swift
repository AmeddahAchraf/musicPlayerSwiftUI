import Combine
import Foundation

final class SongViewModel: ObservableObject {
    @Published var songs: [Song] = []
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let networkService = NetworkService.shared

    func fetchSongs(songType: SongType) {
        let songsRequest = FetchSongsRequest(songType: songType)

        networkService.request(songsRequest)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { (response: ApiResponse) in
                self.songs = response.result.tagSong.result
            })
            .store(in: &cancellables)
    }
}
