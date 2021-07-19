//
//  CustomTabBarController.swift
//  Hexagram
//
//  Created by aiqin139 on 2021/7/17.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var modelData: ModelData!
    
    init(_ modelData: ModelData) {
        self.modelData = modelData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func addChildViewControllers() {
        setChildrenController(title: "占卦", image: UIImage(systemName: "star")!, controller: PredictionNavigationController(self.modelData))
        setChildrenController(title: "卦象", image: UIImage(systemName: "bonjour")!, controller: HexagramNavigationController(self.modelData))
        setChildrenController(title: "更多", image: UIImage(systemName: "ellipsis.circle")!, controller: MoreViewNavigationController(self.modelData))
    }

    private func setChildrenController(title:String, image:UIImage, controller:CustomNavigationController) {
        controller.tabBarItem.title = title
        controller.tabBarItem.image = image
        controller.tabBarItem.selectedImage = image
        addChild(controller)
    }
}
