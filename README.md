# BottomSheetPresenter

A lightweight Swift package that provides a unified interface for presenting bottom sheets across all iOS versions starting from iOS 13.


## Features

- ✅ Unified API for sheet presentation (Uses `UISheetPresentationController` on iOS 16+, Uses a custom `UIViewController` for iOS 13–15)
- ✅ Supports for `.custom(height: CGFloat) / .medium` / `.large` detents
- ✅ Optional grabber (`prefersGrabberVisible`)
- ✅ Dismissal control (`isDismissable`)
- ✅ Optional content clipping control (`allowsContentOutOfBounds`)
> ⚠️ **Note:** The current version only supports **Portrait orientation**. Landscape mode is not supported yet.


## Requirements

- iOS 13+
- Swift 5.7+
- Xcode 14+


## Usage

### Basic Example

#### UIKit
```swift
let contentVC = YourContentViewController()
let sheet = BottomSheetPresenter(content: contentVC)
sheet.detents = [.medium, .large]
sheet.prefersGrabberVisible = true
sheet.isDismissable = true
sheet.allowsContentOutOfBounds = true // Allow content to extend beyond the sheet's bounds
sheet.present(from: self)
```

#### SwiftUI
```swift
let sheet = BottomSheetPresenter(view: YourSwiftUIContentView())
sheet.detents = [.custom(height: 200), .medium]
sheet.prefersGrabberVisible = true
sheet.present(from: self, animated: true)
```

### Programmatic Dismiss

```swift
contentVC.dismiss(animated: true)
```

### Using Custom Sheet Height with Multiple Detents

```swift
sheet.detents = [.custom(height: 300), .large]
```


## License

MIT

---

Created with ❤️ by Retrica
