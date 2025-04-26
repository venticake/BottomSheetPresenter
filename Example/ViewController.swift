//
//  ViewController.swift
//  Example
//
//  Created by Sangwon Park on 4/25/25.
//

import UIKit
import BottomSheetPresenter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let left = 40
        let top = 80
        let width = 160
        let height = 40

        var button = UIButton(type: .system)
        var buttons = [UIButton]()

        // modern
        buttons = [UIButton]()

        button = UIButton(type: .system)
        button.setTitle("modern (iOS 16+)", for: .normal)
        button.addTarget(self, action: #selector(presentModern), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("large + medium", for: .normal)
        button.addTarget(self, action: #selector(presentModernLargeMedium), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("medium + large", for: .normal)
        button.addTarget(self, action: #selector(presentModernMediumLarge), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("medium", for: .normal)
        button.addTarget(self, action: #selector(presentModernMedium), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("medium + grabber", for: .normal)
        button.addTarget(self, action: #selector(presentModernMediumGrabber), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("non dismissable", for: .normal)
        button.addTarget(self, action: #selector(presentModernNonDismissable), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("[300 x 200]", for: .normal)
        button.addTarget(self, action: #selector(presentModern300x200), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("[300 x 200] + m + l", for: .normal)
        button.addTarget(self, action: #selector(presentModern300x200MediumLarge), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("[300 x 200] + l", for: .normal)
        button.addTarget(self, action: #selector(presentModern300x200Large), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("[x 200] + m + l (not d)", for: .normal)
        button.addTarget(self, action: #selector(presentModern300x200MediumLargeNotDismissable), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("[x 200] + m (noanim)", for: .normal)
        button.addTarget(self, action: #selector(presentModern300x200MediumNoAnimated), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        let stackView0 = UIStackView(arrangedSubviews: buttons)
        stackView0.axis = .vertical
        stackView0.frame = CGRect(x: left, y: top, width: width, height: height * buttons.count)
        stackView0.backgroundColor = .systemGray6
        view.addSubview(stackView0)


        // legacy
        buttons = [UIButton]()

        button = UIButton(type: .system)
        button.setTitle("legacy", for: .normal)
        button.addTarget(self, action: #selector(presentLegacy), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("large + medium", for: .normal)
        button.addTarget(self, action: #selector(presentLegacyLargeMedium), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("medium + large", for: .normal)
        button.addTarget(self, action: #selector(presentLegacyMediumLarge), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("medium", for: .normal)
        button.addTarget(self, action: #selector(presentLegacyMedium), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("medium + grabber", for: .normal)
        button.addTarget(self, action: #selector(presentLegacyMediumGrabber), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("non dismissable", for: .normal)
        button.addTarget(self, action: #selector(presentLegacyNonDismissable), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("[300 x 200]", for: .normal)
        button.addTarget(self, action: #selector(presentLegacy300x200), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("[300 x 200] + m + l", for: .normal)
        button.addTarget(self, action: #selector(presentLegacy300x200MediumLarge), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("[300 x 200] + l", for: .normal)
        button.addTarget(self, action: #selector(presentLegacy300x200Large), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("[x 200] + m + l (not d)", for: .normal)
        button.addTarget(self, action: #selector(presentLegacy300x200MediumLargeNotDismissable), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        button = UIButton(type: .system)
        button.setTitle("[x 200] + m (noanim)", for: .normal)
        button.addTarget(self, action: #selector(presentLegacy300x200MediumNoAnimated), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        let stackView1 = UIStackView(arrangedSubviews: buttons)
        stackView1.axis = .vertical
        stackView1.frame = CGRect(x: left + width, y: top, width: width, height: height * buttons.count)
        stackView1.backgroundColor = .systemGray5
        view.addSubview(stackView1)
    }

    // modern button events

    @objc func presentModern() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.present(from: self)
    }

    @objc func presentModernLargeMedium() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detents = [.large, .medium]
        sheet.present(from: self)
    }

    @objc func presentModernMediumLarge() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detents = [.medium, .large]
        sheet.present(from: self)
    }

    @objc func presentModernMedium() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detents = [.medium]
        sheet.present(from: self)
    }

    @objc func presentModernMediumGrabber() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detents = [.medium]
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    @objc func presentModernNonDismissable() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detents = [.medium]
        sheet.prefersGrabberVisible = false
        sheet.isDismissable = false
        sheet.present(from: self)
    }

    @objc func presentModern300x200() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detents = [.custom(height: 200)]
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    @objc func presentModern300x200MediumLarge() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detents = [.custom(height: 200), .medium, .large]
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    @objc func presentModern300x200Large() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detents = [.custom(height: 200), .large]
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    @objc func presentModern300x200MediumLargeNotDismissable() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detents = [.custom(height: 200), .medium, .large]
        sheet.prefersGrabberVisible = true
        sheet.isDismissable = false
        sheet.present(from: self)
    }

    @objc func presentModern300x200MediumNoAnimated() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detents = [.custom(height: 200), .medium]
        sheet.prefersGrabberVisible = true
        sheet.present(from: self, animated: false)
    }

    // legacy button events

    @objc func presentLegacy() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.present(from: self)
    }

    @objc func presentLegacyLargeMedium() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detents = [.large, .medium]
        sheet.present(from: self)
    }

    @objc func presentLegacyMediumLarge() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detents = [.medium, .large]
        sheet.present(from: self)
    }

    @objc func presentLegacyMedium() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detents = [.medium]
        sheet.present(from: self)
    }

    @objc func presentLegacyMediumGrabber() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detents = [.medium]
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    @objc func presentLegacyNonDismissable() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detents = [.medium]
        sheet.prefersGrabberVisible = false
        sheet.isDismissable = false
        sheet.present(from: self)
    }

    @objc func presentLegacy300x200() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detents = [.custom(height: 200)]
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    @objc func presentLegacy300x200MediumLarge() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detents = [.custom(height: 200), .medium, .large]
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    @objc func presentLegacy300x200Large() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detents = [.custom(height: 200), .large]
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    @objc func presentLegacy300x200MediumLargeNotDismissable() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detents = [.custom(height: 200), .medium, .large]
        sheet.prefersGrabberVisible = true
        sheet.isDismissable = false
        sheet.present(from: self)
    }

    @objc func presentLegacy300x200MediumNoAnimated() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detents = [.custom(height: 200), .medium]
        sheet.prefersGrabberVisible = true
        sheet.present(from: self, animated: false)
    }
}

// MARK: - ColorViewController

class ColorViewController: UIViewController {

    let color: UIColor

    init(color: UIColor, preferredContentSize: CGSize? = nil) {
        self.color = color
        super.init(nibName: nil, bundle: nil)
        if let preferredContentSize {
            self.preferredContentSize = preferredContentSize
        }
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = color

        let contentSizeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: preferredContentSize.width, height: preferredContentSize.height))
        contentSizeLabel.backgroundColor = UIColor.cyan.withAlphaComponent(0.5)
        contentSizeLabel.textAlignment = .center
        contentSizeLabel.text = "\(preferredContentSize.width) x \(preferredContentSize.height)";
        contentSizeLabel.layer.masksToBounds = true
        contentSizeLabel.layer.cornerRadius = 20.0
        view.addSubview(contentSizeLabel)

        let button = UIButton(type: .system)
        button.setTitle("close", for: .normal)
        button.frame = CGRect(x: 20, y: 20, width: 80, height: 40)
        button.addTarget(self, action: #selector(closeButtonTouched), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc func closeButtonTouched() {
        self.dismiss(animated: true)
    }
}
