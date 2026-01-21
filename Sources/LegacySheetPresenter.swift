//
//  LegacySheetPresenter.swift
//  BottomSheetPresenter
//
//  Created by Sangwon Park on 4/25/25.
//

import UIKit

class LegacySheetPresenter: BottomSheetPresenting {
    var detents: [BottomSheetDetent] = [.large]
    var prefersGrabberVisible: Bool = false
    var isDismissable: Bool = true
    var allowsContentOutOfBounds: Bool = false
    var preferredCornerRadius: CGFloat? = nil

    private let content: UIViewController

    init(content: UIViewController) {
        self.content = content
    }

    func presentSheet(from parent: UIViewController, animated: Bool) {
        let sheetVC = CustomBottomSheetViewController(
            content: content,
            detents: detents,
            grabber: prefersGrabberVisible,
            isDismissable: isDismissable,
            clipsToBounds: !allowsContentOutOfBounds,
            parentViewSafeAreaInsets: parent.view.safeAreaInsets,
            cornerRadius: preferredCornerRadius
        )
        sheetVC.modalPresentationStyle = .custom

        if animated {
            parent.present(sheetVC, animated: true)
        } else {
            parent.present(sheetVC, animated: false)
            sheetVC.dimmedView.alpha = 1.0
            sheetVC.containerView.transform = .identity
        }
    }
}

// MARK: - CustomBottomSheetViewController

protocol CustomBottomSheetViewControllerDelegate: AnyObject {
    func bottomSheetDidDismiss()
}

class CustomBottomSheetViewController: UIViewController {
    weak var dismissDelegate: CustomBottomSheetViewControllerDelegate?

    private let contentVC: UIViewController
    private let detents: [BottomSheetDetent]
    private var currentDetent: BottomSheetDetent
    private let showGrabber: Bool
    private let isDismissable: Bool
    private let clipsToBounds: Bool
    private let parentViewSafeAreaInsets: UIEdgeInsets
    private let cornerRadius: CGFloat

    let dimmedView = UIView()
    let containerView = UIView()

    private var containerHeight: CGFloat = 0.0
    private var containerViewHeightConstraint: NSLayoutConstraint?

    init(content: UIViewController, detents: [BottomSheetDetent], grabber: Bool, isDismissable: Bool, clipsToBounds: Bool, parentViewSafeAreaInsets: UIEdgeInsets, cornerRadius: CGFloat? = nil) {
        self.contentVC = content
        self.detents = detents
        self.currentDetent = detents.first ?? .large
        self.showGrabber = grabber
        self.isDismissable = isDismissable
        self.clipsToBounds = clipsToBounds
        self.parentViewSafeAreaInsets = parentViewSafeAreaInsets
        self.cornerRadius = cornerRadius ?? 12.0

        super.init(nibName: nil, bundle: nil)

        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom

        self.containerHeight = currentDetent.height + parentViewSafeAreaInsets.bottom
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed {
            dismissDelegate?.bottomSheetDidDismiss()
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
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        containerView.clipsToBounds = self.clipsToBounds
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: containerHeight)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerViewHeightConstraint!
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
            grabber.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
            grabber.layer.cornerRadius = 2.5
            grabber.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(grabber)

            NSLayoutConstraint.activate([
                grabber.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
                grabber.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                grabber.widthAnchor.constraint(equalToConstant: 36),
                grabber.heightAnchor.constraint(equalToConstant: 5)
            ])
        }

        // 5. Pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        containerView.addGestureRecognizer(panGesture)
    }

    @objc private func dismissSelf() {
        self.dismiss(animated: true)
    }

    // MARK: - Gesture Handling

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view).y

        switch gesture.state {
        case .changed:
            var adjustedTranslationY = translation.y

            let maximumDetent = detents.max(by: { $0.height < $1.height }) ?? currentDetent
            let minimumDetent = detents.min(by: { $0.height < $1.height }) ?? currentDetent

            let maximumHeight = maximumDetent.height + parentViewSafeAreaInsets.bottom
            let minimumHeight = minimumDetent.height + parentViewSafeAreaInsets.bottom

            let expectedHeight = containerHeight - adjustedTranslationY

            if expectedHeight > maximumHeight {
                // Overflow resistance
                let overflow = expectedHeight - maximumHeight
                adjustedTranslationY += overflow * 0.7
            } else if !isDismissable && expectedHeight < minimumHeight {
                // Underflow resistance
                let overflow = minimumHeight - expectedHeight
                adjustedTranslationY -= overflow * 0.7
            }

            let newHeight = containerHeight - adjustedTranslationY
            updateHeight(for: newHeight)

        case .ended:
            let dragVelocity = velocity
            let dragTranslation = translation.y

            // 0.1 Very smooth inertia
            // 0.2 Similar to system seat (recommended)
            // 0.3 or more jerky bouncing (aggressive)
            let velocityFactor: CGFloat = 0.1

            // finalHeight estimation: translation + some value based on velocity
            let predictedTranslation = dragTranslation + (dragVelocity * velocityFactor)
            let finalHeight = containerHeight - predictedTranslation

            let isAtLowestDetent = currentDetent == detents.min(by: { $0.height < $1.height })

            let shouldDismiss = isDismissable && isAtLowestDetent &&
                (dragTranslation > containerHeight * 0.5 || dragVelocity > 1000)

            if shouldDismiss {
                dismissSelf()
                return
            }

            // snap to nearest detent
            let targetDetent = detents.min(by: { abs($0.height - finalHeight) < abs($1.height - finalHeight) }) ?? currentDetent
            currentDetent = targetDetent

            // animation with spring timing
            let springTiming = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: CGVector(dx: 0, dy: 0))
            let animator = UIViewPropertyAnimator(duration: 0.4, timingParameters: springTiming)
            animator.addAnimations {
                self.updateHeight()
            }
            animator.startAnimation()

        default:
            break
        }
    }

    private func updateHeight(for customHeight: CGFloat? = nil) {
        guard let containerViewHeightConstraint else { return }
        if let customHeight {
            containerViewHeightConstraint.constant = customHeight
        } else {
            self.containerHeight = currentDetent.height + parentViewSafeAreaInsets.bottom
            containerViewHeightConstraint.constant = containerHeight
        }
        view.layoutIfNeeded()
    }
}

extension CustomBottomSheetViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return BottomSheetTransitionAnimator(isPresenting: true, containerHeight: containerHeight)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetTransitionAnimator(isPresenting: false, containerHeight: containerHeight)
    }
}

// MARK: - BottomSheetTransitionAnimator

fileprivate class BottomSheetTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let isPresenting: Bool
    private let containerHeight: CGFloat

    init(isPresenting: Bool, containerHeight: CGFloat) {
        self.isPresenting = isPresenting
        self.containerHeight = containerHeight
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
            bottomSheet.containerView.transform = CGAffineTransform(translationX: 0, y: containerHeight)

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
                    bottomSheet.containerView.transform = CGAffineTransform(translationX: 0, y: self.containerHeight)
                },
                completion: { finished in
                    transitionContext.completeTransition(finished)
                }
            )
        }
    }
}
