import SwiftUI

struct TabItemView: View {
    let type: ChannelType

    var body: some View {
        switch type {
        case .sd: return Text("SD")
        case .hd: return Text("HD")
        case .radio: return Text("Radio")
        }
    }
}

@main
struct Application: SwiftUI.App {
    @State private var sd = [Channel]()
    @State private var hd = [Channel]()
    @State private var radio = [Channel]()

    let discovery = Discovery()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TabView {
                    CollectionView(channels: $sd)
                        .tabItem { TabItemView(type: .sd) }
                        .task { $sd.wrappedValue = try! await discovery.fetchChannels(type: .sd) }
                    CollectionView(channels: $hd)
                        .tabItem { TabItemView(type: .hd) }
                        .task { $hd.wrappedValue = try! await discovery.fetchChannels(type: .hd) }
                    CollectionView(channels: $radio)
                        .tabItem { TabItemView(type: .radio) }
                        .task { $radio.wrappedValue = try! await discovery.fetchChannels(type: .radio) }
                }
            }
        }
    }
}
