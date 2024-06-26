import ProjectDescription

let config = Config(
    compatibleXcodeVersions: .upToNextMajor("15.0"),
    swiftVersion: "5.9.0",
    generationOptions: .options(enforceExplicitDependencies: true)
)
