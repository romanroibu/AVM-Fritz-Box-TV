import ProjectDescription

let productName = "Fritz!TV"
let bundlePrefix = "xyz.uncluttering.fritz-tv"

let project = Project(
    name: productName,
    targets: [
        .target(
            name: "tvos-app",
            destinations: .tvOS,
            product: .app,
            productName: productName,
            bundleId: "\(bundlePrefix).tvos",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .external(name: "SDWebImageSwiftUI"),
                .external(name: "VLCKitSPM"),
            ],
            // Required by SDWebImage
            // See: https://docs.tuist.io/guide/project/dependencies#objective-c-dependencies
            settings: .settings(base: ["OTHER_LDFLAGS": "$(inherited) -ObjC"])
        ),
        .target(
            name: "tvos-tests",
            destinations: .tvOS,
            product: .unitTests,
            bundleId: "\(bundlePrefix).tvos-tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "tvos-app"),
            ]
        ),
    ]
)
