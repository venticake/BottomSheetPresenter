//
//  BottomSheetPresenter.swift
//  BottomSheetPresenter
//
//  Created by Sangwon Park on 4/25/25.
//

import UIKit

// MARK: - BottomSheetDetent

public enum BottomSheetDetent {
    case medium
    case large
    case custom(height: CGFloat)

    var height: CGFloat {
        switch self {
        case .medium:
            return UIScreen.main.bounds.height * 0.5
        case .large:
            return UIScreen.main.bounds.height * 0.87
        case .custom(let height):
            return height
        }
    }
}

extension BottomSheetDetent: Equatable {

    public static func == (lhs: BottomSheetDetent, rhs: BottomSheetDetent) -> Bool {
        switch (lhs, rhs) {
        case (.medium, .medium), (.large, .large):
            return true
        case let (.custom(lh), .custom(rh)):
            return abs(lh - rh) < 0.1 // Tolerance (may be slightly off by a few decimal points)
        default:
            return false
        }
    }
}

// MARK: - BottomSheetPresenter

public class BottomSheetPresenter {
    public var detents: [BottomSheetDetent] = [.large]
    public var prefersGrabberVisible: Bool = false
    public var isDismissable: Bool = true

    private var presenter: BottomSheetPresenting

    public init(content: UIViewController, useLegacyForcely: Bool = false) {
        if (useLegacyForcely) {
            presenter = LegacySheetPresenter(content: content)
        } else {
            if #available(iOS 16.0, *) {
                presenter = ModernSheetPresenter(content: content)
            } else {
                presenter = LegacySheetPresenter(content: content)
            }
        }
    }

    public func present(from parent: UIViewController, animated: Bool = true) {
        presenter.detents = detents
        presenter.prefersGrabberVisible = prefersGrabberVisible
        presenter.isDismissable = isDismissable
        presenter.presentSheet(from: parent, animated: animated)
    }
}

import SwiftUI

public extension BottomSheetPresenter {

    convenience init(view: some View, useLegacyForcely: Bool = false) {
        self.init(content: UIHostingController(rootView: view), useLegacyForcely: useLegacyForcely)
    }
}

// MARK: - BottomSheetPresenting

protocol BottomSheetPresenting {
    var detents: [BottomSheetDetent] { get set }
    var prefersGrabberVisible: Bool { get set }
    var isDismissable: Bool { get set }
    func presentSheet(from parent: UIViewController, animated: Bool)
}
