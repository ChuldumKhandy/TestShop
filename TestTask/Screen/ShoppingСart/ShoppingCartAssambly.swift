//
//  ShoppingCartAssambly.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 17.07.2022.
//

import UIKit

class ShoppingCartAssambly {
    static func build() -> UIViewController {
        let presenter = ShoppingCartPresenter()
        let controller = ShoppingCartViewController(presenter: presenter)
        return controller
    }
}
