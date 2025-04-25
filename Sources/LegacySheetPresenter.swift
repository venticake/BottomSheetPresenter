//
//  LegacySheetPresenter.swift
//  BottomSheetPresenter
//
//  Created by Sangwon Park on 4/25/25.
//

import UIKit

class LegacySheetPresenter: BottomSheetPresenting {
    var detent: BottomSheetDetent = .large
    var prefersGrabberVisible: Bool = false
    var isDismissable: Bool = true
    private let content: UIViewController

    init(content: UIViewController) {
        self.content = content
    }

    func presentSheet(from parent: UIViewController) {
        let sheetVC = CustomBottomSheetViewController(content: content, detent: detent, grabber: prefersGrabberVisible, isDismissable: isDismissable, parentViewSafeAreaInsets: parent.view.safeAreaInsets)
        sheetVC.modalPresentationStyle = .custom
        parent.present(sheetVC, animated: true)
    }
}

// MARK: - CustomBottomSheetViewController

fileprivate class CustomBottomSheetViewController: UIViewController {
    private let contentVC: UIViewController
    private let detent: BottomSheetDetent
    private let showGrabber: Bool
    private let isDismissable: Bool
    private let parentViewSafeAreaInsets: UIEdgeInsets

    let dimmedView = UIView()
    let containerView = UIView()

    private var containerHeight: CGFloat = 0.0
    private var containerViewHeight: CGFloat = 0.0

    init(content: UIViewController, detent: BottomSheetDetent, grabber: Bool, isDismissable: Bool, parentViewSafeAreaInsets: UIEdgeInsets) {
        self.contentVC = content
        self.detent = detent
        self.showGrabber = grabber
        self.isDismissable = isDismissable
        self.parentViewSafeAreaInsets = parentViewSafeAreaInsets

        super.init(nibName: nil, bundle: nil)

        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom

        self.containerHeight = calculateContainerHeight()
        self.containerViewHeight = containerHeight + parentViewSafeAreaInsets.bottom
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func calculateContainerHeight() -> CGFloat {
        // 우선 preferredContentSize.height를 우선적으로 사용
        let preferredHeight = contentVC.preferredContentSize.height

        if preferredHeight > 0 {
            return preferredHeight
        }

        switch detent {
        case .medium:
            return UIScreen.main.bounds.height * 0.5
        case .large:
            return UIScreen.main.bounds.height * 0.85
        }
    }

    private func setupViews() {
        view.backgroundColor = .clear

        // 1. Dimmed View
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimmedView.alpha = 0.0
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dimmedView)

        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        if (isDismissable) {
            dimmedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSelf)))
        }

        // 2. Container View
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: containerViewHeight)
        ])

        // 3. Content View (먼저)
        addChild(contentVC)
        contentVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentVC.view)

        NSLayoutConstraint.activate([
            contentVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            contentVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contentVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contentVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        contentVC.didMove(toParent: self)

        // 4. Grabber (Content 위에)
        if showGrabber {
            let grabber = UIView()
            grabber.backgroundColor = .systemGray3
            grabber.layer.cornerRadius = 2.5
            grabber.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(grabber)

            NSLayoutConstraint.activate([
                grabber.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
                grabber.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                grabber.widthAnchor.constraint(equalToConstant: 36),
                grabber.heightAnchor.constraint(equalToConstant: 5)
            ])
        }

        // 5. Pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.delegate = self
        containerView.addGestureRecognizer(panGesture)
    }

    @objc private func dismissSelf() {
        self.dismiss(animated: true)
    }

    // MARK: - Gesture Handling

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard isDismissable else { return }

        let translation = gesture.translation(in: view)

        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                containerView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended:
            let velocity = gesture.velocity(in: view).y
            if velocity > 1000 || translation.y > containerViewHeight / 2 {
                dismissSelf()
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.containerView.transform = .identity
                }
            }
        default:
            break
        }
    }
}

extension CustomBottomSheetViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return BottomSheetTransitionAnimator(isPresenting: true, containerViewHeight: containerViewHeight)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetTransitionAnimator(isPresenting: false, containerViewHeight: containerViewHeight)
    }
}

extension CustomBottomSheetViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return isDismissable
    }
}

// MARK: - BottomSheetTransitionAnimator

fileprivate class BottomSheetTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let isPresenting: Bool
    private let containerViewHeight: CGFloat

    init(isPresenting: Bool, containerViewHeight: CGFloat) {
        self.isPresenting = isPresenting
        self.containerViewHeight = containerViewHeight
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }

        let containerView = transitionContext.containerView

        if isPresenting {
            containerView.addSubview(toVC.view)

            toVC.view.frame = containerView.bounds
            toVC.view.layoutIfNeeded()

            guard let bottomSheet = toVC as? CustomBottomSheetViewController else {
                transitionContext.completeTransition(true)
                return
            }

            bottomSheet.view.layoutIfNeeded()

            bottomSheet.dimmedView.alpha = 0.0
            bottomSheet.containerView.transform = CGAffineTransform(translationX: 0, y: containerViewHeight)

            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                delay: 0,
                options: [.curveEaseOut],
                animations: {
                    bottomSheet.dimmedView.alpha = 1.0
                    bottomSheet.containerView.transform = .identity
                },
                completion: { finished in
                    transitionContext.completeTransition(finished)
                }
            )
        } else {
            guard let bottomSheet = fromVC as? CustomBottomSheetViewController else {
                transitionContext.completeTransition(true)
                return
            }

            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                delay: 0,
                options: [.curveEaseOut],
                animations: {
                    bottomSheet.dimmedView.alpha = 0.0
                    bottomSheet.containerView.transform = CGAffineTransform(translationX: 0, y: self.containerViewHeight)
                },
                completion: { finished in
                    transitionContext.completeTransition(finished)
                }
            )
        }
    }
}
