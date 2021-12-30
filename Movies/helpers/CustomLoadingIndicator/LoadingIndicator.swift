//
//  LoadingIndicator.swift
//
//  Created by azah on 6/1/21.
//

import UIKit

class LoadingIndicator: UIVisualEffectView {

  var text: String? {
    didSet {
      label.text = text
    }
  }

    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView

  init(text: String) {
    self.text = text
    self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
    super.init(effect: blurEffect)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    self.text = ""
    self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
    super.init(coder: aDecoder)
    self.setup()
  }

  func setup() {
    activityIndictor.assignColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    contentView.addSubview(vibrancyView)
    contentView.addSubview(activityIndictor)
    if text != "" {
        contentView.addSubview(label)
    }

    contentView.backgroundColor = .clear
    activityIndictor.startAnimating()
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    if let superview = self.superview {

      let width = superview.frame.size.width / 2.3
      let height: CGFloat = 50.0
      self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                      y: superview.frame.height / 2 - height / 2,
                      width: width,
                      height: height)
      vibrancyView.frame = self.bounds

      let activityIndicatorSize: CGFloat = 40

        let padding: CGFloat = (contentView.frame.width - 40) / 2
        
        activityIndictor.anchor(top: contentView.topAnchor,
                                leading: contentView.leadingAnchor,
                           bottom: contentView.bottomAnchor,
                           trailing: contentView.trailingAnchor,
                           padding: .init(top: 5,
                                          left: padding,
                                          bottom: 5, right: padding),
                         size: CGSize(width: activityIndicatorSize, height: activityIndicatorSize))

      layer.cornerRadius = 8.0
      layer.masksToBounds = true
    }
  }
    
}
extension UIActivityIndicatorView {
    func assignColor(_ color: UIColor) {
        style = .large
        self.color = color
    }
}
