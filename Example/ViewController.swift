//
//  ViewController.swift
//  Example
//
//  Created by Sangwon Park on 4/25/25.
//

import UIKit

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

        let stackView0 = UIStackView(arrangedSubviews: buttons)
        stackView0.axis = .vertical
        stackView0.frame = CGRect(x: left, y: top, width: width, height: height * buttons.count)
        view.addSubview(stackView0)


        // legacy
        buttons = [UIButton]()

        button = UIButton(type: .system)
        button.setTitle("legacy", for: .normal)
        button.addTarget(self, action: #selector(presentLegacy), for: .touchUpInside)
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

        let stackView1 = UIStackView(arrangedSubviews: buttons)
        stackView1.axis = .vertical
        stackView1.frame = CGRect(x: left + width, y: top, width: width, height: height * buttons.count)
        view.addSubview(stackView1)
    }

    // modern button events

    @objc func presentModern() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.present(from: self)
    }

    @objc func presentModernMedium() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detent = .medium
        sheet.present(from: self)
    }

    @objc func presentModernMediumGrabber() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detent = .medium
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    @objc func presentModernNonDismissable() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detent = .medium
        sheet.prefersGrabberVisible = false
        sheet.isDismissable = false
        sheet.present(from: self)
    }

    @objc func presentModern300x200() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent)
        sheet.detent = .medium
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    // legacy button events

    @objc func presentLegacy() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.present(from: self)
    }

    @objc func presentLegacyMedium() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detent = .medium
        sheet.present(from: self)
    }

    @objc func presentLegacyMediumGrabber() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detent = .medium
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }

    @objc func presentLegacyNonDismissable() {
        let sheetContent = ColorViewController(color: .orange)
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detent = .medium
        sheet.prefersGrabberVisible = false
        sheet.isDismissable = false
        sheet.present(from: self)
    }

    @objc func presentLegacy300x200() {
        let sheetContent = ColorViewController(color: .orange, preferredContentSize: CGSize(width: 300, height: 200))
        let sheet = BottomSheetPresenter(content: sheetContent, useLegacyForcely: true)
        sheet.detent = .medium
        sheet.prefersGrabberVisible = true
        sheet.present(from: self)
    }
}


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
        button.frame = CGRect(x: 40, y: 40, width: 80, height: 40)
        button.addTarget(self, action: #selector(closeButtonTouched), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc func closeButtonTouched() {
        self.dismiss(animated: true)
    }
}
