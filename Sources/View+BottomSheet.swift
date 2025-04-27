//
//  View+BottomSheet.swift
//  Example
//
//  Created by Sangwon Park on 4/27/25.
//

import SwiftUI

public extension View {
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        detents: [BottomSheetDetent] = [.large],
        prefersGrabberVisible: Bool = false,
        isDismissable: Bool = true,
        useLegacyForcely: Bool = false,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.background(
            BottomSheetPresenterView(
                isPresented: isPresented,
                detents: detents,
                prefersGrabberVisible: prefersGrabberVisible,
                isDismissable: isDismissable,
                useLegacyForcely: useLegacyForcely,
                onDismiss: onDismiss,
                content: content)
        )
    }
}

fileprivate struct BottomSheetPresenterView<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let detents: [BottomSheetDetent]
    let prefersGrabberVisible: Bool
    let isDismissable: Bool
    let useLegacyForcely: Bool
    let onDismiss: (() -> Void)?
    let content: () -> Content

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.presentationController?.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented && uiViewController.presentedViewController == nil {
            let hostingVC = UIHostingController(rootView: content())
            let presenter = BottomSheetPresenter(content: hostingVC, useLegacyForcely: useLegacyForcely)
            presenter.detents = detents
            presenter.prefersGrabberVisible = prefersGrabberVisible
            presenter.isDismissable = isDismissable
            presenter.present(from: uiViewController, animated: true)

            if let customVC = uiViewController.presentedViewController as? CustomBottomSheetViewController {
                customVC.dismissDelegate = context.coordinator
            }
            hostingVC.presentationController?.delegate = context.coordinator
        } else if !isPresented && uiViewController.presentedViewController != nil {
            uiViewController.dismiss(animated: true)
        } else if isPresented && uiViewController.presentedViewController == nil {
            DispatchQueue.main.async {
                context.coordinator.isPresented = false
                context.coordinator.onDismiss?()
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented, onDismiss: onDismiss)
    }

    // MARK: - Coordinator

    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate, CustomBottomSheetViewControllerDelegate {
        @Binding var isPresented: Bool
        let onDismiss: (() -> Void)?

        init(isPresented: Binding<Bool>, onDismiss: (() -> Void)?) {
            self._isPresented = isPresented
            self.onDismiss = onDismiss
        }

        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            isPresented = false
            onDismiss?()
        }

        // CustomBottomSheetViewControllerDelegate
        func bottomSheetDidDismiss() {
            isPresented = false
            onDismiss?()
        }
    }
}
