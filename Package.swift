import PackageDescription

let package = Package(
    name: "SSLExample",
    dependencies: [
        .Package(url: "https://github.com/gtaban/Kitura.git", Version(0, 28, 1)),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 0, minor: 15),
        .Package(url: "https://github.com/IBM-Swift/BlueSSLService.git", majorVersion: 0, minor: 10)
    ])

