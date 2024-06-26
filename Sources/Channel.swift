import Foundation

enum ChannelType: String, Identifiable {
    case sd, hd, radio
    
    var id: String { rawValue }
}

struct Channel: Identifiable {
    let type: ChannelType
    let title: String
    let streamUrl: URL
    let thumbnailUrl: URL

    var id: String { streamUrl.absoluteString }
}
