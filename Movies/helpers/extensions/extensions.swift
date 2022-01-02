//
//  UIExtensions.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import UIKit
import SDWebImage

extension UIView {
        
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
extension UIViewController {
    func showLoadinIndicator(viewController: UIViewController) {
        let indicator = LoadingIndicator(text: "")
        if viewController.view.subviews.first(where: {$0 is UIVisualEffectView}) == nil {
            addParentView(viewController: viewController)
            viewController.view.addSubview(indicator)
        }
    }
    func removeLoadingIndicator(viewController: UIViewController) {
        if let indicator  = viewController.view.subviews.first(where: {$0 is UIVisualEffectView}) , let blockView = viewController.view.subviews.first(where: {$0.tag == 2}){
            blockView.removeFromSuperview()
            indicator.removeFromSuperview()
        } else {
            print("fail to delete")
        }
    }
    func addParentView(viewController: UIViewController) {
        let customView = UIView()
        customView.tag = 2
        viewController.view.addSubview(customView)
        customView.anchor(top: viewController.view.topAnchor, leading: viewController.view.leadingAnchor,
                        bottom: viewController.view.bottomAnchor, trailing: viewController.view.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                         size: customView.frame.size)
        customView.backgroundColor = .clear
        customView.isUserInteractionEnabled = true
    }
    
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }


}
extension UIImageView {
    func downloadImage(url : String, placeHolder : UIImage?) throws{
        if let url = URL(string: url){
            self.sd_imageIndicator?.startAnimatingIndicator()
            self.sd_setImage(with: url) { (image, err, type, url) in
                if err != nil{
                    self.sd_imageIndicator?.stopAnimatingIndicator()
                    print("Failed to download image")
                }
                self.sd_imageIndicator?.stopAnimatingIndicator()
            }
        }

    }
    
}

class ContentSizedTableView: UITableView {
    
    override func awakeFromNib() {
        self.backgroundColor = .white
    }
    
    override var contentSize: CGSize {
        didSet {

            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

}
