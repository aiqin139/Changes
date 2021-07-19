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
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}


class PredictionNavigationController: CustomNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostVC = UIHostingController(rootView: PredictionNavigationView().environmentObject(self.modelData))
        
        self.setViewControllers([hostVC], animated: true)
        
        self.navigationBar.prefersLargeTitles = true
    }
}


class HexagramNavigationController: CustomNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostVC = UIHostingController(rootView: HexagramNavigationView().environmentObject(self.modelData))
        
        self.setViewControllers([hostVC], animated: true)
        
        self.navigationBar.prefersLargeTitles = true
    }
}


class MoreViewNavigationController: CustomNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostVC = UIHostingController(rootView: MoreNavigationView().environmentObject(self.modelData))
        
        self.setViewControllers([hostVC], animated: true)
    }
}
