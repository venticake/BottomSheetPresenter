//
//  BottomSheetPresenter.swift
//  BottomSheetPresenter
//
//  Created by Sangwon Park on 4/25/25.
//

import UIKit

public enum BottomSheetDetent {
    case medium
    case large
}

public class BottomSheetPresenter {
    public var detent: BottomSheetDetent = .large
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

    public func present(from parent: UIViewController) {
        presenter.detent = detent
        presenter.prefersGrabberVisible = prefersGrabberVisible
        presenter.isDismissable = isDismissable
        presenter.presentSheet(from: parent)
    }
}

protocol BottomSheetPresenting {
    var detent: BottomSheetDetent { get set }
    var prefersGrabberVisible: Bool { get set }
    var isDismissable: Bool { get set }
    func presentSheet(from parent: UIViewController)
}
