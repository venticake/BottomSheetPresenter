// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "BottomSheetPresenter",
    platforms: [
        .iOS(.v13) // supports iOS 13 and later
    ],
    products: [
        .library(
            name: "BottomSheetPresenter",
            targets: ["BottomSheetPresenter"]
        ),
    ],
    targets: [
        .target(
            name: "BottomSheetPresenter",
            path: "Sources"
        )
    ]
)
