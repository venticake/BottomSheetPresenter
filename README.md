# BottomSheetPresenter

A lightweight Swift package that provides a unified interface for presenting bottom sheets across all iOS versions starting from iOS 13.


## Features

- ✅ Unified API for sheet presentation (Uses `UISheetPresentationController` on iOS 16+, Uses a custom `UIViewController` for iOS 13–15)
- ✅ Supports for `.medium` / `.large` detents
- ✅ Supports `preferredContentSize` for dynamic height
- ✅ Optional grabber (`prefersGrabberVisible`)
- ✅ Dismissal control (`isDismissable`)
> ⚠️ **Note:** The current version only supports **Portrait orientation**. Landscape mode is not supported yet.


## Requirements

- iOS 13+
- Swift 5.7+
- Xcode 14+


## Usage

### Basic Example

```swift
let contentVC = YourContentViewController()
let sheet = BottomSheetPresenter(content: contentVC)
sheet.detent = .medium
sheet.prefersGrabberVisible = true
sheet.isDismissable = true
sheet.present(from: self)
```

### Programmatic Dismiss

```swift
contentVC.dismiss(animated: true)
```

### Using Preferred Content Size

```swift
contentVC.preferredContentSize = CGSize(width: 0, height: 300)
```


## License

MIT

---

Created with ❤️ by Retrica
