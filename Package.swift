// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SheetPresenter",
    platforms: [
        .iOS(.v13) // supports iOS 13 and later
    ],
    products: [
        .library(
            name: "SheetPresenter",
            targets: ["SheetPresenter"]
        ),
    ],
    targets: [
        .target(
            name: "SheetPresenter",
            path: "Sources"
        )
    ]
)
