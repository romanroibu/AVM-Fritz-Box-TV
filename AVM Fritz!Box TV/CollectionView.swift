import SwiftUI

struct CollectionView: View {
    @Binding var channels: [Channel]
    let columns: Int = 3

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: gridColumns) {
                ForEach(channels) { channel in
                    NavigationLink {
                        PlayerView(mediaUrl: channel.streamUrl)
                    } label: {
                        VStack {
                            ThumbnailView(url: channel.thumbnailUrl).frame(width: 400, height: 250)
                            Text(verbatim: channel.title)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var gridColumns: [GridItem] {
        let item = GridItem(.flexible(minimum: 100, maximum: .infinity))
        return (0..<columns).map { _ in item }
    }
}
