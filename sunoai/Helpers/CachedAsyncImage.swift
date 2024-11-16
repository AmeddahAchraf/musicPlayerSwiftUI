import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?
    var body: some View {
        if let url = url {
            AsyncImage(url: url, transaction: Transaction(animation: .default)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                case .failure(_):
                    Image(systemName: "photo")
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}
