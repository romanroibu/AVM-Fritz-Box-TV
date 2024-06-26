// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [:]
)
#endif

let package = Package(
    name: "Fritz!TV",
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/tylerjonesio/vlckit-spm/", .upToNextMajor(from: "3.5.1")),
    ]
)
