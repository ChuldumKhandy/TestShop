//
//  MainTabBarController.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let firstVC = ListOfGoodsAssambly.build()
    private let secondVC = ShoppingCartAssambly.build()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstVC.tabBarItem.title = "Товары"
        firstVC.tabBarItem.image = UIImage(systemName: "line.3.horizontal")
        secondVC.tabBarItem.title = "Корзина"
        secondVC.tabBarItem.image = UIImage(systemName: "bag")
        
        viewControllers = [firstVC, secondVC]
    }
    
}



