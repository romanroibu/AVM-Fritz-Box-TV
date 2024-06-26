import Foundation

class Discovery {
    private let host: URL

    init() {
        // @TODO: Discover host URL at runtime
        self.host = URL(string: "http://192.168.178.1")!
    }

    func fetchChannels(type: ChannelType) async throws -> [Channel] {
        let regex = /^#EXTINF:0,(.*)\n.*\n(.*)$/
            .anchorsMatchLineEndings()
            .ignoresCase()

        let path = {
            switch type {
            case .sd: return "/dvb/m3u/tvsd.m3u"
            case .hd: return "/dvb/m3u/tvhd.m3u"
            case .radio: return "/dvb/m3u/radio.m3u"
            }
        }()

        let url = URL(string: path, relativeTo: host)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let str = String(data: data, encoding: .utf8)!
        let matches = str.matches(of: regex)

        return matches.map { match in
            let title = String(match.output.1)
            let streamUrl = URL(string: String(match.output.2))!

            let logoNs = {
                switch type {
                case .sd: return ""
                case .hd: return "hd/"
                case .radio: return "radio/"
                }
            }()

            let logoId = title.lowercased()
                .replacingOccurrences(of: "ä", with: "ae", options: .regularExpression)
                .replacingOccurrences(of: "ö", with: "oe", options: .regularExpression)
                .replacingOccurrences(of: "ü", with: "ue", options: .regularExpression)
                .replacingOccurrences(of: "ß", with: "ss", options: .regularExpression)
                .replacingOccurrences(of: "[.,-]", with: "", options: .regularExpression)
                .replacingOccurrences(of: "[ /]+", with: "_", options: .regularExpression)

            return Channel(
                type: type,
                title: title,
                streamUrl: streamUrl,
                thumbnailUrl: URL(string: "https://tv.avm.de/tvapp/logos/\(logoNs)/\(logoId).png")!
            )
        }
    }
}
