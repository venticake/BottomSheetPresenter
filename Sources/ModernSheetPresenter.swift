//
//  ModernSheetPresenter.swift
//  BottomSheetPresenter
//
//  Created by Sangwon Park on 4/25/25.
//

import UIKit

/// UISheetPresentationController is available starting from iOS 15.0, but iOS 16.0 or later is required to use custom detents.
@available(iOS 16.0, *)
class ModernSheetPresenter: BottomSheetPresenting {
    var detents: [BottomSheetDetent] = [.large]
    var prefersGrabberVisible: Bool = false
    var isDismissable: Bool = true

    private let content: UIViewController

    init(content: UIViewController) {
        self.content = content
    }

    func presentSheet(from parent: UIViewController, animated: Bool) {
        content.modalPresentationStyle = .pageSheet

        if let sheet = content.sheetPresentationController {
            // Detents
            sheet.detents = detents.map { detent in
                switch detent {
                case .medium:
                    return .medium()
                case .large:
                    return .large()
                case .custom(let height):
                    return .custom(identifier: .init("custom_\(Int(height))")) { _ in height }
                }
            }
            sheet.prefersGrabberVisible = prefersGrabberVisible
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true

            // Prevent dismissal by background
            if !isDismissable {
                sheet.largestUndimmedDetentIdentifier = nil
            }
        }

        // Prevent dismissal by background
        content.isModalInPresentation = !isDismissable

        parent.present(content, animated: animated)
    }
}
