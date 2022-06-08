//
//  CustomNavigationController.swift
//  Hexagram
//
//  Created by aiqin139 on 2021/7/18.
//

import UIKit
import SwiftUI

class CustomNavigationController: UINavigationController {
    
    public var modelData: ModelData!
    
    init(_ modelData: ModelData) {
        self.modelData = modelData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customNavigation() {
        self.navigationBar.tintColor = (UITraitCollection.current.userInterfaceStyle == .dark) ? .white : .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigation()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        customNavigation()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

class HostingTableViewCell<Content: View>: UITableViewCell {
    private weak var controller: UIHostingController<Content>?

    func setView(_ view: Content, parent: UIViewController) {
        if let controller = controller {
            controller.rootView = view
            controller.view.layoutIfNeeded()
        } else {
            let hostVC = UIHostingController(rootView: view)
            hostVC.view.backgroundColor = .clear
            controller = hostVC

            layoutIfNeeded()

            parent.addChild(hostVC)
  
            contentView.addSubview(hostVC.view)
            hostVC.view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addConstraint(NSLayoutConstraint(item: hostVC.view!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: hostVC.view!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: hostVC.view!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: hostVC.view!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))

            hostVC.didMove(toParent: parent)
            hostVC.view.layoutIfNeeded()
        }
    }
}


class HostingCollectionViewCell<Content: View>: UICollectionViewCell {
    private weak var controller: UIHostingController<Content>?

    func setView(_ view: Content, parent: UIViewController) {
        if let controller = controller {
            controller.rootView = view
            controller.view.layoutIfNeeded()
        } else {
            let hostVC = UIHostingController(rootView: view)
            hostVC.view.backgroundColor = .clear
            controller = hostVC

            layoutIfNeeded()

            parent.addChild(hostVC)
  
            contentView.addSubview(hostVC.view)
            hostVC.view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addConstraint(NSLayoutConstraint(item: hostVC.view!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: hostVC.view!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: hostVC.view!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: hostVC.view!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))

            hostVC.didMove(toParent: parent)
            hostVC.view.layoutIfNeeded()
        }
    }
}


extension UIViewController {
    func pushOrShowDetailView(_ hostVC: UIViewController, _ title: String) {
        if splitViewController?.isCollapsed == false {
            splitViewController?.showDetailViewController(UINavigationController(rootViewController: hostVC), sender: self)
        } else {
            hostVC.navigationItem.title = title
            hostVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.navigationBar.isHidden = false
            navigationController?.popViewController(animated: true)
            navigationController?.pushViewController(hostVC, animated: true)
        }
    }
}
