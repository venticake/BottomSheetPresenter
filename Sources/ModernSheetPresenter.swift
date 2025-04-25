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
    var detent: BottomSheetDetent = .large
    var prefersGrabberVisible: Bool = false
    var isDismissable: Bool = true
    private let content: UIViewController

    init(content: UIViewController) {
        self.content = content
    }

    func presentSheet(from parent: UIViewController) {
        content.modalPresentationStyle = .pageSheet

        if let sheet = content.sheetPresentationController {
            // Detent
            var detents = [UISheetPresentationController.Detent]()
            if self.content.preferredContentSize.height > 0.0 {
                detents.append(.custom(identifier: .init("preferredHeight"), resolver: { context in
                    self.content.preferredContentSize.height
                }))
            }

            switch detent {
            case .medium: detents.append(.medium())
            case .large: detents.append(.large())
            }

            sheet.detents = detents

            sheet.prefersGrabberVisible = prefersGrabberVisible
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true

            // Dimmed background 클릭시 dismiss 방지
            if !isDismissable {
                sheet.largestUndimmedDetentIdentifier = nil
            }
        }

        // 드래그로 dismiss 방지
        content.isModalInPresentation = !isDismissable

        parent.present(content, animated: true)
    }
}
