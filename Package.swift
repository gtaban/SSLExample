import PackageDescription

let package = Package(
    name: "SSLExample",
    dependencies: [
        .Package(url: "https://github.com/gtaban/Kitura.git", majorVersion: 0, minor: 31),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 0, minor: 16),
    ])

