//
//  ViewController.swift
//  Example
//
//  Created by Sangwon Park on 4/25/25.
//

import UIKit
import BottomSheetPresenter
import SwiftUI

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
        button.setTitle("medium out of bounds", for: .normal)
        button.addTarget(self, action: #selector(presentModernMediumOutOfBounds), for: .touchUpInside)
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

        button = UIButton(type: .system)
        button.setTitle("SwiftUI [x 200] + m", for: .normal)
        button.addTarget(self, action: #selector(presentModernSwiftUI300x200Medium), for: .touchUpInside)
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
        button.setTitle("medium out of bounds", for: .normal)
        button.addTarget(self, action: #selector(presentLegacyMediumOutOfBounds), for: .touchUpInside)
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

        button = UIButton(type: .system)
        button.setTitle("SwiftUI [x 200] + m", for: .normal)
        button.addTarget(self, action: #selector(presentLegacySwiftUI300x200Medium), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttons.append(button)

        let stackView1 = UIStackView(arrangedSubviews: buttons)
        stackView1.axis = .vertical
        stackView1.frame = CGRect(x: left + width, y: top, width: width, height: height * buttons.count)
        stackView1.backgroundColor = .systemGray5
        view.addSubview(stackView1)

        // add open StartView(swiftUI)
        let openStartViewButton = UIButton(type: .system)
        openStartViewButton.setTitle("StartView (SwiftUI)", for: .normal)
        openStartViewButton.addTarget(self, action: #selector(openStartView), for: .touchUpInside)
        openStartViewButton.frame = CGRect(x: left, y: top + height * buttons.count, width: width * 2, height: height)
        openStartViewButton.backgroundColor = .lightGray
        view.addSubview(openStartViewButton)
    }

    @objc func openStartView() {
        DispatchQueue.main.async {
            self.present(UIHostingController(rootView: StartView()), animated: true)
        }
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

    @objc func presentModernMediumOutOfBounds() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, allowsContentOutOfBounds: true)
        sheet.detents = [.medium]
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

    @objc func presentModernSwiftUI300x200Medium() {
        if #available(iOS 15.0, *) {
            let sheet = BottomSheetPresenter(view: ColorView(color: .green))
            sheet.detents = [.custom(height: 200), .medium]
            sheet.prefersGrabberVisible = true
            sheet.present(from: self, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "SwiftUI is not available on this version of iOS.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
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

    @objc func presentLegacyMediumOutOfBounds() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true, allowsContentOutOfBounds: true)
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

    @objc func presentLegacySwiftUI300x200Medium() {
        if #available(iOS 15.0, *) {
            let sheet = BottomSheetPresenter(view: ColorView(color: .green), useLegacyForcely: true)
            sheet.detents = [.custom(height: 200), .medium]
            sheet.prefersGrabberVisible = true
            sheet.present(from: self, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "SwiftUI is not available on this version of iOS.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
