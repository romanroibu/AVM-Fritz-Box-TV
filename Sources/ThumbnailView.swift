import SwiftUI
import SDWebImageSwiftUI

struct ThumbnailView: View {
    let url: URL

    var body: some View {
        WebImage(url: url) { image in
            image.resizable()
        } placeholder: {
            Rectangle().foregroundColor(.gray)
        }
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .scaledToFit()
    }
}
