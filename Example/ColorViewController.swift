//
//  ColorViewController.swift
//  Example
//
//  Created by Sangwon Park on 4/27/25.
//

import UIKit

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
        self.view.clipsToBounds = false

        let rectangleView = UIView(frame: CGRect(x: 100, y: -100, width: 200, height: 300))
        rectangleView.backgroundColor = .blue
        rectangleView.layer.cornerRadius = 20.0
        view.addSubview(rectangleView)

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
