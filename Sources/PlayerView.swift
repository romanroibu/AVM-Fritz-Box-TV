import SwiftUI
import VLCKitSPM

struct PlayerView: UIViewControllerRepresentable {
    
    var mediaUrl: URL

    typealias UIViewControllerType = PlayerViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        let vc = UIViewControllerType()
        vc.mediaUrl = mediaUrl
        return vc
    }

    func updateUIViewController(_ vc: UIViewControllerType, context: Context) {
        vc.mediaUrl = mediaUrl
    }
}

class PlayerViewController: UIViewController {
    var mediaUrl: URL? {
        didSet { updateMediaUrl(newUrl: mediaUrl, oldUrl: oldValue) }
    }
    
    private var videoView: UIView!

    private var mediaPlayer: VLCMediaPlayer!
    
    private func updateMediaUrl(newUrl: URL?, oldUrl: URL?) {
        guard newUrl?.absoluteString != oldUrl?.absoluteString else { return }
        guard let mediaPlayer = mediaPlayer else { return }

        mediaPlayer.stop()
        mediaPlayer.media = newUrl.map(VLCMedia.init(url:))
        mediaPlayer.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        videoView = UIView(frame: view.bounds)
        mediaPlayer = VLCMediaPlayer()
        mediaPlayer.drawable = view
        updateMediaUrl(newUrl: mediaUrl, oldUrl: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        mediaPlayer?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mediaPlayer?.pause()
    }

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)

        for press in presses {
            switch press.type {
            case .playPause:
                guard let mediaPlayer = mediaPlayer else { break }
                if mediaPlayer.isPlaying {
                    mediaPlayer.pause()
                } else {
                    mediaPlayer.play()
                }
            default:
                break
            }
        }
    }
}
